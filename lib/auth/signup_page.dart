import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/main_page.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';

import 'package:todo_app/widgets/auth_backgorund.dart';

import '../apps/todo_app/viewmodel/authcontroller.dart';
import '../apps/todo_app/viewmodel/mainpagecontroller.dart';
import '../uitils/widgets/buttonbacground.dart';
import '../uitils/widgets/validator.dart';
import '../widgets/customsnackbar.dart';

class SignupPage extends StatelessWidget{

  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController retypepasswordcontroller = TextEditingController();
  final controller=Get.put(Authcontroller());

  SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        controller.isloadingsignup.value=false;
        controller.ischeck.value=false;
      },
      child: Scaffold(

        body: SizedBox(height: Get.height,width: Get.width,
          child: authbackgroundadd(SizedBox(
            height: ( Get.height-Get.height*0.3)>520?520:Get.height*0.68,
            width: Get.width-30,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formkey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Container(height: 567,)
                                customtextfeild(
                                  lines: 1,
                                    validatortest: (value) {
                                      return basicvalidator(value!);
                                    },
                                    hint: "Name",
                                    obscure: false,
                                    title: "Name",
                                    controller: namecontroller),
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
                                      return createpasswordvaliator(value);
                                    },
                                    hint: "******",
                                    obscure: true,
                                    title: "Password",
                                    controller: passwordcontroller),
                                customtextfeild(
                                  lines: 1,
                                    validatortest: (value) {
                                      return matchpassword(value, passwordcontroller);
                                    },
                                    hint: "password",
                                    obscure: true,
                                    title: "Retype password",
                                    controller: retypepasswordcontroller),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Obx(
                                    ()=> DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: controller.dropdownbuttonvalue.value,
                                        icon: Icon(Icons.arrow_drop_down),
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                        iconSize: 24,
                                        elevation: 16,
                                        items: [
                                        DropdownMenuItem(value:"Teacher",child: Text("Teacher")),
                                        DropdownMenuItem(value:"Student",child: Text("Student")),
                                      ], onChanged: (value) {
                                          controller.dropdownbuttonvalue.value=value!;
                                      },),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Obx(
                                          ()=> Checkbox(
                                         checkColor: Colors.white,
                                        value: controller.ischeck.value,
                                        onChanged: (value) {
                                          controller.ischeck.value = value!;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                          text: const TextSpan(children: [
                                            TextSpan(
                                                text: "I agree to the ",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: "Term and Condition",
                                                style: TextStyle(color: Colors.blue)),
                                            TextSpan(
                                                text: " & ",
                                                style: TextStyle(color: Colors.grey)),
                                            TextSpan(
                                                text: "Privacy Policy",
                                                style: TextStyle(color: Colors.blue)),
                                          ])),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Obx(
                            () => controller
                            .isloadingsignup.value
                            ? CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation(Colors.deepPurple),
                        )
                            : SizedBox(
                            width:
                            MediaQuery.sizeOf(context).width - 50,
                            child: buttonbackground(
                                "Signup",
                                () async{
                                  if (controller.ischeck.value) {
                                    final isvalid = _formkey
                                        .currentState!
                                        .validate();
                                    if (isvalid) {
                                      controller.isloadingsignup.value=true;
                                      try {
                                        controller
                                            .signupmethod(
                                            email: emailcontroller
                                                .text,
                                            password:
                                            passwordcontroller
                                                .text,
                                            context: context)
                                            .then(
                                              (value) => controller
                                              .storeuserdata(
                                              name:
                                              namecontroller
                                                  .text,
                                              email:
                                              emailcontroller
                                                  .text,
                                              password:
                                              passwordcontroller
                                                  .text, field: controller.dropdownbuttonvalue.value),
                                        )
                                            .then(
                                              (value) {
                                            customsnackbar("Logged in Successfully",
                                                "Enjoy your self.");
                                            controller.isloadingsignup
                                                .value = false;
                                            Get.put(Mainpagecontroller());
                                            Get.offAll(MainPage());
                                          },
                                        );
                                      } catch (e) {
                                        controller.isloadingsignup.value=false;
                                        controller.auth.signOut();
                                        customsnackbar("Error", e.toString());
                                      }
                                    }
                                  }
                                },
                              )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? ",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            width: 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.isloadingsignup.value = false;
                              Get.back();
                            },
                            child: const Text("Login",
                                style: TextStyle(color: Colors.blueAccent,decoration: TextDecoration.underline,decorationColor: Colors.blue,decorationThickness: 1)),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),

                ],
              ),
            ),
          ),"Signup!"),),
      ),
    );
  }
}