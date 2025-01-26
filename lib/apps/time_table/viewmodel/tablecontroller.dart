import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class Tablecontroller extends GetxController{
  var searchtext="".obs;
  final weeks = ["Week 1", "Week 2", "Week 3", "Week 4"];
  final days = ["Monday", "Tuesday", "Wednesday", "Thursday","Friday"];
  var year="".obs;
  var month="".obs;
  var day="monday".obs;
  RxInt monthindex=1.obs;
  var weekindex=0.obs;
  var dayindex=0.obs;
  getmonthname(int month1){
    switch(month1){
      case 1:
        month.value="january";
        break;
        case 2:
          month.value="February";
          break;
      case 3:
        month.value="March";
        break;
      case 4:
        month.value="april";
        break;
      case 5:
        month.value="may";
        break;
      case 6:
        month.value="june";
        break;
      case 7:
        month.value="july";
        break;
      case 8:
        month.value="august";
        break;
      case 9:
        month.value="september";
        break;
      case 10:
        month.value="october";
        break;
      case 11:
        month.value="november";
        break;
      case 12:
        month.value="december";
        break;
      default:
        break;
    }
  }
}
