import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/auth/forgord_password.dart';
import 'package:todo_app/auth/signup_page.dart';
import 'package:todo_app/main_page.dart';
import 'package:todo_app/uitils/widgets/buttonbacground.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';
import 'package:todo_app/widgets/auth_backgorund.dart';

import '../apps/todo_app/viewmodel/authcontroller.dart';
import '../apps/todo_app/viewmodel/mainpagecontroller.dart';
import '../uitils/const/images_const.dart';
import '../uitils/widgets/validator.dart';
import '../widgets/customsnackbar.dart';

class Loginpage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final controller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: authbackgroundadd(
            SizedBox(
              height: (Get.height - Get.height * 0.3) > 530
                  ? 530
                  : Get.height * 0.68,
              width: Get.width - 30,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(height: 500,),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _formkey,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Obx(
                                    () => Container(
                                      width: Get.width - 80,
                                      height: 45,
                                      child: Stack(
                                        children: [
                                          // Background for swipe area
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildOption('Teacher', true),
                                              _buildOption('Student', false),
                                            ],
                                          ),
                                          // Swipe animation
                                          AnimatedPositioned(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            left: controller.isteacher.value
                                                ? 0
                                                : (Get.width - 80)/2,
                                            child:
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                // Background Image
                                                SizedBox(
                                                  width: (Get.width - 80)/2,
                                                  height: 45,
                                                  child: ClipRRect(
                                                    borderRadius: controller.isteacher.value==true?BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
                                                    child: Image.asset(
                                                      authbackground, // Replace with your image URL
                                                      width: 200,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // Blur Effect
                                                SizedBox(
                                                  width: (Get.width - 80)/2,
                                                  height: 45,
                                                  child: ClipRRect(
                                                    borderRadius:  controller.isteacher.value==true?BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                                      child: Container(
                                                        width: 200,
                                                        height: 100,
                                                        color: Colors.black.withOpacity(0.3), // Adjust opacity
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Gradient Overlay
                                                Container(
                                                  width: (Get.width - 80)/2,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    borderRadius:  controller.isteacher.value==true?BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black.withOpacity(0.3),
                                                        Colors.transparent,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    ),
                                                  ),
                                                ),
                                                // Button Text
                                                Container(
                                                  width: (Get.width - 80)/2,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.blue,
                                                    borderRadius:
                                                    controller.isteacher.value==true?BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    controller.isteacher.value
                                                        ? 'Teacher'
                                                        : 'Student',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  customtextfeild(
                                      lines: 1,
                                      validatortest: (value) {
                                        return emailvalidate(value);
                                      },
                                      hint: "example@gmail.com",
                                      obscure: false,
                                      title: "Email",
                                      controller: emailcontroller),
                                  customtextfeild(
                                      lines: 1,
                                      validatortest: (value) {
                                        return passwordvalidate(value);
                                      },
                                      hint: "******",
                                      obscure: true,
                                      title: "Password",
                                      controller: passwordcontroller),
                                ],
                              )),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(ForgordPassword());
                                },
                                child: const Text("forgotpassword"))),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                              () => controller
                              .isloadinglogin.value
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                          )
                              : SizedBox(
                              width: MediaQuery.sizeOf(context).width - 50,
                              child: buttonbackground(
                                  "Login",
                                    () async{
                                    final isvalid =
                                    _formkey.currentState!.validate();
                                    if (isvalid) {
                                      controller.isloadinglogin.value=true;
                                      var check=await controller.checkuser(controller.isteacher.value?"teacher":"student",emailcontroller.text.trim());
                                      if(check){
                                        print("check= $check");
                                        controller
                                            .loginmethod(
                                            email: emailcontroller.text,
                                            password:
                                            passwordcontroller.text,
                                            context: context)
                                            .then(
                                              (value) {
                                            if (value != null) {
                                              controller.isloadinglogin
                                                  .value = false;
                                              Get.put(Mainpagecontroller());
                                              Get.offAll(MainPage());
                                              customsnackbar("Login", "Enjoy your Self.");
                                            } else {
                                              controller.isloadinglogin.value=false;
                                            }
                                          },
                                        );
                                      }else{
                                        customsnackbar("Error", "You are not registered as ${controller.isteacher.value? "teacher":"student"}");
                                        controller.isloadinglogin.value=false;
                                      }

                                    }
                                  },
                                  )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "create new account",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            height: 42,
                            width: MediaQuery.sizeOf(context).width - 50,
                            child: buttonbackground("Signup", () {
                              Get.to(SignupPage());
                            })),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Login with",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                // backgroundColor: lightGrey,
                                radius: 25,
                                child: Image.asset(
                                  socialIconlist[index],
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            "Login!"),
      ),
    );
  }

  Widget _buildOption(String label, bool isTeacherOption) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.isteacher.value =
          !controller.isteacher.value;
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: label=="Teacher"?BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
