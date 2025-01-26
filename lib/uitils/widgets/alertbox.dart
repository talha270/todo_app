import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/custombutton.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

alertbox({required message,required VoidCallback voidcallback}){
  return Get.defaultDialog(
      // barrierDismissible: false,
      titlePadding: EdgeInsets.all(12),
      // middleText: "Are you completed the task.",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customtext(text: message,size: 15),
        ],
      ),
      title: "Alert Box",
    cancel: TextButton(onPressed: () {
      Get.back();
    }, child: Text("Cancel")),
    confirm: TextButton(onPressed: () {
      voidcallback();
    }, child: Text("Yes")),
  );
}
