import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_info_app_bb2/utils/colors.dart';
import '../controllers/user_controller.dart';

class FormScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustColors.secondaryColor.withAlpha(100),
          title: Text('User Information',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: userController.formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: userController.nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your name';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: userController.ageController,
                    decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your age';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.dobController,
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder()

                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your date of birth';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.genderController,
                    decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder()

                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your gender';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.employmentStatusController,
                    decoration: InputDecoration(
                        labelText: 'Employment Status',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your employment status';
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.employeeAddressController,
                    decoration: InputDecoration(
                        labelText: 'Employee Address',
                        border: OutlineInputBorder()

                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your employee address';
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: CustColors.primaryColor),
                    onPressed: () {
                      if (userController.formKey.currentState!.validate()) {
                        userController.submitData();
                      }
                    },
                    child: Text('Submit',style: GoogleFonts.poppins(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
