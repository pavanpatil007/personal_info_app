import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_info_app_bb2/utils/colors.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import 'form_screen.dart';

class UserListScreen extends StatelessWidget {
   UserListScreen({super.key});

  final UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustColors.secondaryColor,
          title: Text('User List',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18),)),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return
              snapshot.data!.docs.length==0?Center(child: FloatingActionButton.extended(
                  backgroundColor: CustColors.primaryColor,
                  onPressed: (){
                    Get.to(()=>FormScreen());
                  },
                  label: Text("Add Information",style: GoogleFonts.poppins(color: Colors.white),)),):
              ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var user = UserModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                return Card(
                  surfaceTintColor: Colors.white,
                  elevation: 5,
                  child: ListTile(
                    title: Text(user.name,style: GoogleFonts.poppins(fontWeight: FontWeight.w500),),
                    subtitle: Text(user.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            userController.loadUserData(user);
                            Get.to(() => FormScreen());
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            userController.deleteUserData(user);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
