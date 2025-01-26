import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/time_table/viewmodel/updatelecturecontroller.dart';
import 'package:todo_app/apps/time_table/widgets/listforms.dart';

import '../../../uitils/widgets/custombutton.dart';
updatelectures({data, id, dayname}) {
  final classnamecontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  return Get.bottomSheet(
    PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        print("pressed");
        Updatelecturecontroller.lectures.clear();
      },
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        padding: EdgeInsets.all(12),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "UPdate Class and Lecture Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      ...Updatelecturecontroller.lectures
                          .asMap()
                          .entries
                          .map(
                            (lectureEntry) => LectureForm(
                              lecture: lectureEntry.value,
                              onRemove: () => Updatelecturecontroller.lectures
                                  .removeAt(lectureEntry.key),
                            ),
                          )
                          .toList(),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () =>
                            Updatelecturecontroller.lectures.add(Lecture()),
                        icon: Icon(Icons.add),
                        label: Text("Add Lecture to $dayname"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
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
                        textcolor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: Get.width * 0.4,
                      child: customButton(
                        title: "Save",
                        callback: () async {
                          // Save logic here
                          if (formkey.currentState!.validate()) {
                            await Updatelecturecontroller.updatelecture(
                              id: id,day: dayname,previewdata: data
                            );
                            Get.back();
                          }
                        },
                        bgcolor: Colors.deepPurple,
                        textcolor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
