import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mainpagecontroller extends GetxController{
  var carddata = [
    {
      "title": "Todo",
      "subtitle": "Mange your task with this app.",
      "icon": Icon(
        Icons.add_task,
        size: 25,
      )
    },
    {
      "title": "Time table",
      "subtitle": "See your time table.",
      "icon": Icon(
        Icons.timelapse,
        size: 25,
      )
    },
    {
      "title": "Ecom",
      "subtitle": "Buy your product.",
      "icon": Icon(
        Icons.add_task,
        size: 25,
      )
    },
    {
      "title": "Chat",
      "subtitle": "Communication between two person.",
      "icon": Icon(
        Icons.add_task,
        size: 25,
      )
    },
  ];
  var username="".obs;
  var tabindex=0.obs;
  static var field="".obs;
  @override
  void onInit() {
    super.onInit();
    getuserdata();
  }
  final docref=FirebaseFirestore.instance.collection("account").doc("all");
  getuserdata()async{
    final check=await docref.collection("teacher").doc(FirebaseAuth.instance.currentUser!.uid).get();
    if(check.exists){
      print(check["field"]);
      print(check.exists);
      username.value=check["name"];
      field.value=check["field"];
    }else{
    final student=await docref.collection("student").doc(FirebaseAuth.instance.currentUser!.uid).get();
      print("exists: ${student.exists}");
      print(student["field"]);
      username.value=student["name"];
      field.value=student["field"];

    }
  }
}
