import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';


mainpagecard({
  required icon,
  required String title,
  required String subtitle,
  required VoidCallback callback,
  required Color color,
}) {
  return SizedBox(
    height: 80,
    width: MediaQuery.of(Get.context!).size.width * 0.45, // Use MediaQuery for width

    child: InkWell(
      onTap: callback,
      child: Card(
        color: color,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(Get.context!).size.width * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.transparent,
                shape: CircleBorder(),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: icon,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customtext(
                      text: title,
                      size: 18,
                      wiegth: FontWeight.bold,
                      color: Colors.white.withOpacity(0.7)
                    ),
                    const SizedBox(height: 5),
                    customtext(
                      color: Colors.white.withOpacity(0.3),
                      text: subtitle,
                      size: 15,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
