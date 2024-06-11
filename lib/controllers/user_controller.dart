import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personal_info_app_bb2/screens/user_list_screen.dart';
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final employmentStatusController = TextEditingController();
  final employeeAddressController = TextEditingController();
  RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel? _currentUser;

  Future<void> submitData() async {
    isLoading.value = true;
    update();
    if (_currentUser != null) {
      // Update existing user
      final user = _currentUser!.copyWith(
        name: nameController.text,
        age: int.parse(ageController.text),
        email: emailController.text,
        dob: DateTime.parse(dobController.text),
        gender: genderController.text,
        employmentStatus: employmentStatusController.text,
        employeeAddress: employeeAddressController.text,
      );

      // Update Firestore
      await _firestore.collection('users').doc(user.id).update(user.toJson());

      // Generate and upload new PDF
      final pdf = await generatePdf(user);
      try{
        await _uploadPdfToSftp(user, pdf);
      }catch(e){
        print(e);
      }

      // Update local state
      _currentUser = null;
      update();
    } else {
      // Add new user
      final user = UserModel(
        id: '', // Generate or assign a unique ID
        name: nameController.text,
        age: int.parse(ageController.text),
        email: emailController.text,
        dob: DateTime.parse(dobController.text),
        gender: genderController.text,
        employmentStatus: employmentStatusController.text,
        employeeAddress: employeeAddressController.text,
      );

      // Save to Firestore
      DocumentReference docRef = await _firestore.collection('users').add(user.toJson());
      print(docRef.collection('users').count());
      user.id = docRef.id;
      await docRef.update({'id': docRef.id});

      // Generate PDF
      final pdf = await generatePdf(user);

      // Upload to SFTP
      try{
        await _uploadPdfToSftp(user, pdf);

      }catch(e){
        print(e);
      }
      update();
    }
    isLoading.value = false;
    Get.to(()=>UserListScreen());
    update();
  }

  Future<pw.Document> generatePdf(UserModel user) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('User Information'),
                pw.Text('Name: ${user.name}'),
                pw.Text('Age: ${user.age}'),
                pw.Text('Email: ${user.email}'),
                pw.Text('DOB: ${user.dob.toIso8601String()}'),
                pw.Text('Gender: ${user.gender}'),
                pw.Text('Employment Status: ${user.employmentStatus}'),
                pw.Text('Employee Address: ${user.employeeAddress}'),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  Future<void> _uploadPdfToSftp(UserModel user, pw.Document pdf) async {
    final pdfBytes = await pdf.save();
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File('${directory.path}/user_info.pdf');
    await pdfFile.writeAsBytes(pdfBytes);

    final shell = Shell();

    final sftpCommands = '''
    mkdir -p /${user.name}
    put ${pdfFile.path} /${user.name}/user_info.pdf
    ''';

    await shell.run('''
    sftp flutterDev@ap-southeast-1.sftpcloud.io << 'END_SFTP'
    $sftpCommands
    END_SFTP
    ''');
  }

  void loadUserData(UserModel user) {
    _currentUser = user;
    nameController.text = user.name;
    ageController.text = user.age.toString();
    emailController.text = user.email;
    dobController.text = user.dob.toIso8601String();
    genderController.text = user.gender;
    employmentStatusController.text = user.employmentStatus;
    employeeAddressController.text = user.employeeAddress;
  }

  Future<void> deleteUserData(UserModel user) async {
    // Delete from Firestore
    await _firestore.collection('users').doc(user.id).delete();

    // Delete PDF from SFTP
    final shell = Shell();
    await shell.run('''
    ssh flutterDev@ap-southeast-1.sftpcloud.io rm /${user.name}/user_info.pdf
    ''');

    // Update local state
    _currentUser = null;
    update();
  }
}
