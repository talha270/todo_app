import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';
import'package:intl/intl.dart'as intl;
showdetails(data){
  return Get.bottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))),
      SingleChildScrollView(
        child: Container(
          height: Get.height*0.5,
          width: Get.width,
          margin: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customtext(text: "Details",wiegth: FontWeight.bold,size: 20,color: Colors.deepPurple),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.topLeft,
                child: customtext(text: "Title",wiegth: FontWeight.bold,size: 17,color: Colors.deepPurple),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: customtext(text: data["title"],wiegth: FontWeight.w400,size: 15),
                ),
              ),

              SizedBox(height: 10,),
              Align(
                alignment: Alignment.topLeft,
                child: customtext(text: "Add at:",wiegth: FontWeight.bold,size: 17,color: Colors.deepPurple),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: customtext(text: intl. DateFormat.yMd().add_jm().format( data["addedat"].toDate()),wiegth: FontWeight.w400,size: 15),
                ),
              ),
              data["is_completed"]?Column(
                children: [
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customtext(text: "Completed at:",wiegth: FontWeight.bold,size: 17,color: Colors.deepPurple),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: customtext(text: intl.DateFormat.yMd().add_jm().format( data["completedat"].toDate()),wiegth: FontWeight.w400,size: 15),
                  ),
                ],
              ):SizedBox(),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.topLeft,
                child: customtext(text: "Description:",wiegth: FontWeight.bold,size: 17,color: Colors.deepPurple),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: customtext(text: data["description"],wiegth: FontWeight.w400,size: 15),
              ),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ));
}
