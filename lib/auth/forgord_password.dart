import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/buttonbacground.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';
import 'package:todo_app/widgets/auth_backgorund.dart';

import '../uitils/widgets/custombutton.dart';
import '../uitils/widgets/validator.dart';

class ForgordPassword extends StatelessWidget{
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  ForgordPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(height: Get.height,width: Get.width,
        child: authbackgroundadd(SizedBox(
          height: ( Get.height-Get.height*0.3)>200?200:Get.height*0.68,
          width: Get.width-30,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formkey,
                        child: Column(
                          children: [
                            customtextfeild(
                              lines: 1,
                                validatortest: (value) {
                                  return emailvalidate(value);
                                },
                                hint: "example@gmail.com",
                                obscure: false,
                                title: "Email",
                                controller: emailcontroller),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: buttonbackground(
                         "Send",
                          () async{
                            final isvalid=_formkey.currentState!.validate();
                            if(isvalid){
                              try{
                                await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);

                                showalertbox(context: context,text: "Check your email for forgot the password.");
                              }on FirebaseAuthException catch(ex){
                                showalertbox(context: context,text: ex.toString());
                              }
                            }
                          },),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),"Forgot Password!"),),
    );
  }
}

showalertbox({required BuildContext context,required String text}) {

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(

        elevation: 20,
        // backgroundColor: Colors.red.shade200,
        // icon: Icon(Icons.ac_unit_sharp),
        title: const Text("Reminder"),
        shadowColor: Colors.black,
        scrollable: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Ok")),
        ],
      );
    },
  );
}
