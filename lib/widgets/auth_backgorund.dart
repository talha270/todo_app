import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

import '../uitils/const/images_const.dart';

authbackgroundadd(Widget child,String title){
  return Stack(
    children: [
      // Positioned.fill(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Blur intensity
      //     child: Container(
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [
      //             Colors.white.withOpacity(0.7), // Dark color with opacity
      //             Colors.blue.withOpacity(0.50),
      //           ],
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      Positioned(
        top: -Get.width*0.8,
        // top: -350,
        left: -20,
        child: Container(
          height:Get.width*2,
          width: Get.width*2,
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(600,400)),
            // shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill,image:AssetImage(authbackground))
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
            Positioned.fill(child: Container(
              height:Get.width*2,
              width: Get.width*2,
              decoration: BoxDecoration(
                // color: Colors.red,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(600,400)),
                  // shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.fill,image:AssetImage(authbackground))
              ),
            ),),
              Positioned(
                top: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5.0, sigmaY: 5.0), // Blur intensity
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(600),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     // Colors.white.withOpacity(0.7), // Dark color with opacity
                      //     // Colors.blue.withOpacity(0.50), // Transparent
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                      color: Colors.transparent
                    ),
                  ),
                ),
              ),
          ],),
        ),
      ),

      Positioned(
          top: Get.height*0.05,
          child: Padding(padding: const EdgeInsets.all(12),child: customtext(text: "Welcome!",size: 40,color: Colors.white,wiegth: FontWeight.bold),)),
      Positioned(
          top: Get.height*0.05+40,
          child: Padding(padding: EdgeInsets.all(12),child: customtext(text: title,size: 35,color: Colors.black,wiegth: FontWeight.bold),)),
      Positioned(
          top: Get.height*0.3,
          left: 12,
          // bottom: 1,
          child: Card(
            elevation: 30,
            child: child,
          )),
    ],
  );
}