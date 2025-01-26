import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/time_table/viewmodel/lecture_controlle.dart';
import 'package:todo_app/apps/time_table/viewmodel/tablecontroller.dart';
import 'package:todo_app/apps/time_table/viewmodel/updatelecturecontroller.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

import '../../todo_app/viewmodel/mainpagecontroller.dart';
import '../widgets/update_bottomsheet.dart';

class MoreDetails extends StatelessWidget {
  final controller = Get.find<Tablecontroller>();
  final id;
  var data;
  MoreDetails({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,),onPressed: () {
          Get.back();
        },),
        elevation: 10,
        backgroundColor:Color(0xFF00246B),
        title: customtext(text: "TimeTable", size: 18,color: Colors.white.withOpacity(0.9)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Obx(() => IconButton(
                  //         onPressed: () {
                  //           if (controller.monthindex.value != 1) {
                  //             controller.monthindex.value -= 1;
                  //             controller
                  //                 .getmonthname(controller.monthindex.value);
                  //           }
                  //         },
                  //         icon: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: controller.monthindex.value == 1
                  //               ? Colors.grey
                  //               : Colors.black,
                  //         ))),
                  //     Obx(
                  //       () => customtext(
                  //           text:
                  //               "${controller.year.value} ${controller.month.value}",
                  //           size: 17),
                  //     ),
                  //     Obx(
                  //       () => IconButton(
                  //           onPressed: () {
                  //             if (controller.monthindex.value != 12) {
                  //               controller.monthindex.value += 1;
                  //               controller
                  //                   .getmonthname(controller.monthindex.value);
                  //             }
                  //           },
                  //           icon: Icon(
                  //             Icons.arrow_forward_ios_rounded,
                  //             color: controller.monthindex.value == 12
                  //                 ? Colors.grey
                  //                 : Colors.black,
                  //           )),
                  //     ),
                  //   ],
                  // ),
                  // GridView.builder(
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, mainAxisExtent: 80),
                  //   itemCount: controller.weeks.length,
                  //   shrinkWrap: true,
                  //   itemBuilder: (context, index) {
                  //     return GestureDetector(
                  //       onTap: () {
                  //         controller.weekindex.value = index;
                  //       },
                  //       child: Obx(
                  //         () => Card(
                  //           color: controller.weekindex.value == index
                  //               ?Colors.blueAccent.shade100: Colors.white70,
                  //           child: Center(
                  //               child: customtext(
                  //                   text: controller.weeks[index], size: 15)),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  // const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customtext(
                          text: "Days", size: 18, wiegth: FontWeight.bold),
                      Mainpagecontroller.field.value=="student"?SizedBox():GestureDetector(
                          onTap: () async{
                            await Updatelecturecontroller.getandaddalllecture(data);
                            updatelectures(data: data,id: id,dayname: controller.day.value);
                          },
                          child: const Icon(Icons.edit,size: 25,))
                    ],
                  ),
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.days.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              controller.dayindex.value = index;
                              controller.day.value = controller.days[index].toLowerCase();
                              print(controller.day.value);
                              },
                            child: Card(

                              color: controller.dayindex.value == index
                                  ? Color(0xFF00246B): Colors.white70,
                              elevation: 5,
                              child: SizedBox(
                                height: 50,
                                // width: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    controller.days[index],
                                    style: TextStyle(fontSize: 16,color:  controller.dayindex.value == index
                                        ? Colors.white:Color(0xFF00246B)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Obx(
                        (){
                          // Dynamically generate the stream based on the current day value
                          Stream<QuerySnapshot> lectureStream = AddLectureController.getalllecturesofweek(
                            id,
                            controller.day.value.toString().toLowerCase(),
                          );
                         return StreamBuilder<QuerySnapshot>(
                           stream: lectureStream,
                           builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
                             if (!snapshot.hasData) {
                               return const Center(
                                 child: CircularProgressIndicator(),
                               );
                             }else if(snapshot.data!.docs.length==0){
                               data=null;
                               return Expanded(
                                 child: Center(
                                   child: customtext(text: "No lecture",size: 15),
                                 ),
                               );
                             } else {
                               data = snapshot.data!.docs;
                               return ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: data.length,
                                 itemBuilder: (context, index) {
                                   return Card(
                                     elevation: 20,
                                     color: Colors.white70,
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           customtext(
                                               text: data[index]["subject"],
                                               size: 18,
                                               wiegth: FontWeight.bold),
                                           customtext(
                                               text:
                                               "time: ${data[index]["start_at"]}-${data[index]["end_at"]}",
                                               size: 15,color: Colors.black54),
                                           customtext(
                                               text:
                                               "room ${data[index]["room_no"]}",
                                               size: 15,color: Colors.black54),
                                         ],
                                       ),
                                     ),
                                   );
                                 },
                               );
                             }
                           },
                         );
                        }
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
