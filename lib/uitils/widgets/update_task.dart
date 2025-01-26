import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/firebase_services.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';
import 'package:todo_app/uitils/widgets/custombutton.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

updatetask(TextEditingController titlecontroller,TextEditingController descriptioncontroller,data){
  titlecontroller.text=data["title"];
  descriptioncontroller.text=data["description"];
  return Get.bottomSheet(
      backgroundColor: Colors.white,
      // isDismissible: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))),
      // enableDrag: false,
      Container(
        height: Get.height*0.5,
        width: Get.width,
        margin: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customtext(text: "Add Task",wiegth: FontWeight.bold,size: 20,color: Colors.deepPurple),
              SizedBox(height: 20,),
              customtextfeild(lines:1,validatortest: (p0) {}, hint: "Title", obscure: false, title: "Title", controller: titlecontroller),
              SizedBox(height: 20,),
              customtextfeild(lines:4,validatortest: (p0) {}, hint: "Enter Description", obscure: false, title: "description", controller: descriptioncontroller),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 45,
                      width: Get.width*0.4,
                      child:  customButton(title: "Cancel", callback: () {
                        Get.back();
                      }, bgcolor: Colors.deepPurple, textcolor: Colors.black),),
                    SizedBox(width: Get.width*0.4,
                      height: 45,
                      child:  customButton(title: "Update", callback: () {
                        FirebaseServices.updatetask(titlecontroller.text, descriptioncontroller.text, data.id);
                        Get.back();
                      }, bgcolor: Colors.deepPurple, textcolor: Colors.black),),
                  ],
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ));
}
