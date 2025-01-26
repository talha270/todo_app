import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/images_const.dart';
import 'customtext.dart';

buttonbackground(title, callback) {
  return SizedBox(
    height: 50,
    width: Get.width - 50,
    child: GestureDetector(
        onTap: callback,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            SizedBox(
              height: 50,
              width: Get.width - 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  authbackground, // Replace with your image URL
                  width: 200,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Blur Effect
            SizedBox(
              height: 50,
              width: Get.width - 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: Colors.black.withOpacity(0.3), // Adjust opacity
                  ),
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              height: 50,
              width: Get.width - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Button Text
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
  );
}
