import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/apps/time_table/widgets/listforms.dart';

class AddLectureController extends GetxController {
  final lecturesByDay = {
    "Monday": <Lecture>[Lecture()].obs,
    "Tuesday": <Lecture>[Lecture()].obs,
    "Wednesday": <Lecture>[Lecture()].obs,
    "Thursday": <Lecture>[Lecture()].obs,
    "Friday": <Lecture>[Lecture()].obs,
  }.obs;

  void addLecture(String day) {
    lecturesByDay[day]?.add(Lecture());
  }

  void removeLecture(String day, int index) {
    lecturesByDay[day]?.removeAt(index);
  }

  void clearAllLectures() {
    lecturesByDay.forEach((key, value) => value.clear());
  }

  void addonelectureinall() {
    addLecture("Monday");
    addLecture("Tuesday");
    addLecture("Wednesday");
    addLecture("Thursday");
    addLecture("Friday");
  }

  static final firestore = FirebaseFirestore.instance;
  static Stream<QuerySnapshot> getallclasses() {
    return FirebaseFirestore.instance.collection("timetable").snapshots();
  }

  static getalllecturesofweek(id, day) {
    return firestore
        .collection("timetable")
        .doc(id)
        .collection(day)
        .snapshots();
  }

  static Future<void> addClass(
      String className, Map<String, List<Lecture>> week) async {
    try {
      var ref = firestore.collection("timetable").doc();
      WriteBatch batch =
          firestore.batch(); // Use a batch for better performance
      ref.set({"class": className});
      week.forEach((day, lectures) {
        print("Processing day: $day");
        for (var lecture in lectures) {
          print(
              "Adding lecture for $day: ${lecture.subjectController.text.trim()}");
          var lectureDoc = ref
              .collection(day.toLowerCase())
              .doc(); // Generate a new document for each lecture
          batch.set(lectureDoc, {
            "subject": lecture.subjectController.text.trim(),
            "start_at": lecture.startTimeController.text.trim(),
            "end_at": lecture.endTimeController.text.trim(),
            "room_no": lecture.roomController.text.trim(),
            "teacher_name": lecture.nameController.text.trim(),
          });
        }
      });

      await batch.commit().then(
            (value) => print("Class and timetable added successfully!"),
          ); // Commit all writes as a single transaction
    } catch (e) {
      print("Error adding class: $e");
    }
  }

  bool isEndTimeValid(String startTime, String endTime) {
    final startParts = startTime.split(":");
    final endParts = endTime.split(":");

    // Convert to hours and minutes
    final startHour = int.parse(startParts[0]);
    final startMinute = int.parse(startParts[1].split(" ")[0]);
    final endHour = int.parse(endParts[0]);
    final endMinute = int.parse(endParts[1].split(" ")[0]);

    // Compare times
    if (endHour > startHour ||
        (endHour == startHour && endMinute > startMinute)) {
      return true;
    }
    return false;
  }

  bool isTimeOverlapping(
      String newStart, String newEnd, List<Lecture> lectures) {
    for (Lecture lecture in lectures) {
      final existingStart = lecture.startTimeController.text;
      final existingEnd = lecture.endTimeController.text;

      // Parse existing times
      final existingStartParts = existingStart.split(":");
      final existingEndParts = existingEnd.split(":");
      final existingStartHour = int.parse(existingStartParts[0]);
      final existingStartMinute =
          int.parse(existingStartParts[1].split(" ")[0]);
      final existingEndHour = int.parse(existingEndParts[0]);
      final existingEndMinute = int.parse(existingEndParts[1].split(" ")[0]);

      // Parse new times
      final newStartParts = newStart.split(":");
      final newEndParts = newEnd.split(":");
      final newStartHour = int.parse(newStartParts[0]);
      final newStartMinute = int.parse(newStartParts[1].split(" ")[0]);
      final newEndHour = int.parse(newEndParts[0]);
      final newEndMinute = int.parse(newEndParts[1].split(" ")[0]);

      // Check overlap
      if (!(newEndHour < existingStartHour ||
          (newEndHour == existingStartHour &&
              newEndMinute <= existingStartMinute) ||
          newStartHour > existingEndHour ||
          (newStartHour == existingEndHour &&
              newStartMinute >= existingEndMinute))) {
        return true; // Overlapping
      }
    }
    return false; // No overlap
  }
}
