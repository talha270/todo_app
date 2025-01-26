import'package:flutter/material.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

Widget customtextfeild({required lines,required String? Function(String?) validatortest,required String hint,required bool obscure,required String title,required TextEditingController controller}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      customtext(text: title,size: 16,),
      const SizedBox(height: 5,),
      TextFormField(
        maxLines: lines,
        validator: validatortest,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint,
          isDense: true,
          // fillColor: Colors.grey,
          // filled: true,
          // border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderRadius:BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black)
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius:BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Colors.black)
          ),

        ),
      ),
      const SizedBox(height: 5,),
    ],
  );
}
