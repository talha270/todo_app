import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../uitils/widgets/custom_textfields.dart';



LectureForm({
  required Lecture lecture,
  required VoidCallback onRemove, }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20),
      customtextfeild(
        lines: 1,
        validatortest: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter lecture name";
          }
          return null;
        },
        hint: "Enter teacher name",
        obscure: false,
        title: "Teacher Name",
        controller: lecture.nameController,
      ),
      SizedBox(height: 20),
      customtextfeild(
        lines: 1,
        validatortest: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter room number";
          }
          if (!RegExp(r'^\d+$').hasMatch(value)) {
            return "Room number must contain only digits";
          }
          return null;
        },
        hint: "Enter room number",
        obscure: false,
        title: "Room Number",
        controller: lecture.roomController,
      ),
      SizedBox(height: 20),
      GestureDetector(
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            lecture.startTimeController.text = pickedTime.format(Get.context!);
          }
        },
        child: AbsorbPointer(
          child: customtextfeild(
            lines: 1,
            validatortest: (value) {
              if (value == null || value.isEmpty) {
                return "Please select start time";
              }
              return null;
            },
            hint: "Select start time",
            obscure: false,
            title: "Start Time",
            controller: lecture.startTimeController,
          ),
        ),
      ),
      SizedBox(height: 20),
      GestureDetector(
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            lecture.endTimeController.text = pickedTime.format(Get.context!);
          }
        },


        child: AbsorbPointer(
          child: customtextfeild(
            lines: 1,
            validatortest: (value) {
              if (value == null || value.isEmpty) {
                return "Please select start time";
              }
              return null;
            },
            hint: "Select end time",
            obscure: false,
            title: "End Time",
            controller: lecture.endTimeController,
          ),
        ),
      ),
      SizedBox(height: 20),
      customtextfeild(
        lines: 1,
        validatortest: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter subject name";
          }
          return null;
        },
        hint: "Enter subject name",
        obscure: false,
        title: "Lecture Subject",
        controller: lecture.subjectController,
      ),
      SizedBox(height: 20),
      ElevatedButton.icon(
        onPressed: onRemove,
        icon: Icon(Icons.delete),
        label: Text("Remove Lecture"),
      ),
      Divider(thickness: 2),
    ],
  );
}
class Lecture {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
}
