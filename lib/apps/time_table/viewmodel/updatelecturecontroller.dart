import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/time_table/widgets/listforms.dart';

class Updatelecturecontroller extends GetxController{
  static var lectures=<Lecture>[].obs;
  static getandaddalllecture(data){
    lectures.clear();
    if(data!=null){
      for(int i=0;i<data.length;i++){
        lectures.add(Lecture());
        lectures[lectures.length-1].endTimeController.text=data[i]["end_at"];
        lectures[lectures.length-1].roomController.text=data[i]["room_no"];
        lectures[lectures.length-1].startTimeController.text=data[i]["start_at"];
        lectures[lectures.length-1].subjectController.text=data[i]["subject"];
        lectures[lectures.length-1].nameController.text=data[i]["teacher_name"];

      }
    }
  }
  static updatelecture({id,day,previewdata})async{
    final fire=FirebaseFirestore.instance;  
    if(previewdata!=null){
      for(int i=0;i<previewdata.length;i++){
        fire.collection("timetable").doc(id).collection(day).doc(previewdata[i].id).delete();
      }
    }

    for (var element in lectures) {
      fire.collection("timetable").doc(id).collection(day).doc().set({
        "subject": element.subjectController.text.trim(),
        "start_at": element.startTimeController.text.trim(),
        "end_at": element.endTimeController.text.trim(),
        "room_no": element.roomController.text.trim(),
        "teacher_name": element.nameController.text.trim(),
      });
    }

  }
}
