import'package:flutter/material.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';


customButton({required String title,required VoidCallback callback,required Color bgcolor,required Color textcolor}){
  return ElevatedButton(

      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: bgcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        callback();
      }, child:customtext(text: title,color: textcolor,size: 15));
}
