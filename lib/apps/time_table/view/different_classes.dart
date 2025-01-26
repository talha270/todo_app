import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/time_table/view/more_details.dart';
import 'package:todo_app/apps/time_table/viewmodel/lecture_controlle.dart';
import 'package:todo_app/apps/time_table/viewmodel/tablecontroller.dart';
import 'package:todo_app/apps/time_table/widgets/add_class.dart';
import 'package:todo_app/apps/todo_app/viewmodel/mainpagecontroller.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

class DifferentClasses extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var pass;
  final controller = Get.put(Tablecontroller());
  final searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: Stack(
        fit: StackFit.expand,
        children: [

          SafeArea(
            child: Container(
              margin: EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: TextField(
                        controller: searchcontroller,
                        onChanged: (value) {
                          controller.searchtext.value = value.toString();
                        },
                        decoration: InputDecoration(
                            hintText: "Search classes",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: AddLectureController.getallclasses(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data=snapshot.data!.docs;
                        print("length"+data.length.toString());
                        pass=data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final className =
                                  data[index]["class"];
                              return Obx(
                                () => className.toLowerCase().contains(
                                        controller.searchtext.value
                                            .toLowerCase())
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.year.value =
                                                  DateTime.now().year.toString();
                                              controller.getmonthname(
                                                  DateTime.now().month);
                                              controller.monthindex.value =
                                                  DateTime.now().month;
                                              Get.to(MoreDetails(id: data[index].id,));
                                            },
                                            child: SizedBox(
                                              height: 30,
                                              child: customtext(text: className,size: 18,wiegth: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        IconButton(onPressed: () {
                                          controller.searchtext.value = className.toString();
                                          searchcontroller.text=className;
                                        }, icon: Icon(Icons.directions))
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                )
                                    : SizedBox(),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Mainpagecontroller.field.value=="student"?SizedBox():FloatingActionButton(
        backgroundColor:Color(0xFF00246B),
        shape: CircleBorder(),
        onPressed: () {
          // print(Mainpagecontroller.field.value);
          addClass(formKey: formkey,data: pass.map((value){return value["class"];}).toList());
        },
        child: Icon(Icons.add,color:Colors.white),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
