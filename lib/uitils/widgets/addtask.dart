import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/firebase_services.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';
import 'package:todo_app/uitils/widgets/custombutton.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';
import 'package:todo_app/uitils/widgets/validator.dart';

addtask(GlobalKey<FormState> _formkey, TextEditingController titlecontroller,
    TextEditingController descriptioncontroller) {
  return Get.bottomSheet(
      backgroundColor: Colors.white,
      // isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      // enableDrag: false,
      Container(
        height: Get.height * 0.5,
        width: Get.width,
        margin: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customtext(
                  text: "Add Task",
                  wiegth: FontWeight.bold,
                  size: 20,
                  color: Colors.deepPurple),
              Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            customtextfeild(
                                lines: 1,
                                validatortest: (value) {
                                  if(value!.isEmpty||value==""){
                                    return "Title is required.";
                                  }else if(!RegExp(r'^[a-zA-Z][a-zA-Z0-9 ]*$').hasMatch(value)){
                                    return "Title first is alphabet and next is digits.";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                hint: "Title",
                                obscure: false,
                                title: "Title",
                                controller: titlecontroller),
                            SizedBox(
                              height: 20,
                            ),
                            customtextfeild(
                                lines: null,
                                validatortest: (value) {
                                  if(value!.isEmpty||value==""){
                                    return "Description is required.";
                                  }else if(!RegExp(r'^[a-zA-Z ]*$').hasMatch(value)){
                                    return "Description only contain the alphabets.";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                hint: "Enter Description",
                                obscure: false,
                                title: "description",
                                controller: descriptioncontroller),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 45,
                            width: Get.width * 0.4,
                            child: customButton(
                                title: "Cancel",
                                callback: () {
                                  Get.back();
                                },
                                bgcolor: Colors.deepPurple,
                                textcolor: Colors.black),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            height: 45,
                            child: customButton(
                                title: "Add",
                                callback: () async {
                                  final isvalid =
                                      _formkey.currentState!.validate();
                                  if (isvalid) {
                                    await FirebaseServices.addtotask(
                                        titlecontroller.text.toString().trim(),
                                        descriptioncontroller.text
                                            .toString()
                                            .trim());
                                    Get.back();
                                  } else {
                                    print("error ");
                                  }
                                },
                                bgcolor: Colors.deepPurple,
                                textcolor: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}
