import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_info_app_bb2/utils/colors.dart';
import '../controllers/user_controller.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});
  final UserController userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: CustColors.secondaryColor.withAlpha(100),
          title: Text('User Information',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(()=>Form(
              key: userController.formKey,
              child: ListView(
                children: [
                  userController.isLoading.value?const LinearProgressIndicator():Container(),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: userController.nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your name';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: userController.ageController,
                    decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your age';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.dobController,
                    decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder()

                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your date of birth';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.genderController,
                    decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder()

                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your gender';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.employmentStatusController,
                    decoration: const InputDecoration(
                        labelText: 'Employment Status',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your employment status';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    controller: userController.employeeAddressController,
                    decoration: const InputDecoration(
                        labelText: 'Employee Address',
                        border: OutlineInputBorder()

                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your employee address';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
            )),
          ),
        ),
      ),
    );
  }
}
