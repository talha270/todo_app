import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/time_table/widgets/listforms.dart';
import 'package:todo_app/uitils/widgets/custom_textfields.dart';

import '../../../uitils/widgets/custombutton.dart';
import '../viewmodel/lecture_controlle.dart';

  final controller = Get.put(AddLectureController());
addClass({required GlobalKey<FormState> formKey,data}) {
  final classnamecontroller=TextEditingController();
  return Get.bottomSheet(
    PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        print("pressed");
        controller.clearAllLectures();
        controller.addonelectureinall();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text(
                  "Add Class and Lecture Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customtextfeild(lines: 1, validatortest: (value){
                        if (value == null || value.isEmpty) {
                          return "Please enter lecture name";
                        }else if(data.contains(value)){
                          return "class is already added.";
                        }
                        return null;
                      }, hint: "class name", obscure: false, title: "Class name", controller: classnamecontroller),
                      ...controller.lecturesByDay.entries.map((entry) {
                        String day = entry.key;
                        List<Lecture> lectures = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              day,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            ...lectures
                                .asMap()
                                .entries
                                .map(
                                  (lectureEntry) => LectureForm(
                                lecture: lectureEntry.value,
                                onRemove: () => controller.removeLecture(
                                  day,
                                  lectureEntry.key,
                                )
                              ),
                            ).toList(),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => controller.addLecture(day),
                              icon: Icon(Icons.add),
                              label: Text("Add Lecture to $day"),
                            ),
                          ],
                        );
                      }).toList(),
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
                        callback: () async{
                          // Save logic here
                          if(formKey.currentState!.validate()){
                            await AddLectureController.addClass(classnamecontroller.text.trim(), controller.lecturesByDay);
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
