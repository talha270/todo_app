import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

import '../viewmodel/mainpagecontroller.dart';
import 'maintab_pages/add_page.dart';
import 'maintab_pages/completedpage.dart';
import 'maintab_pages/pending_page.dart';

class MaintabPage extends StatelessWidget {
  final controller = Get.put(Mainpagecontroller());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customtext(
                  text: "Todo App",
                  wiegth: FontWeight.w500,
                  size: 25,
                  color:  Color(0xFF00246B)),
              Obx(() => customtext(
                  text: "Hi ${controller.username.value}",
                  size: 15,
                  wiegth: FontWeight.bold),),
            ],
          ),
          bottom: TabBar(
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor:  Color(0xFF00246B),
              indicatorWeight: 3,
              labelStyle: TextStyle(fontFamily: "style",color: Color(0xFF00246B)),
              tabs: [
                Tab(
                  icon: Icon(Icons.domain_add),
                  text: "Add",
                ),
                Tab(
                  icon: Icon(Icons.pending_actions),
                  text: "Pending",
                ),
                Tab(
                  icon: Icon(Icons.task_alt),
                  text: "completed",
                ),
              ]),
        ),
        body: TabBarView(children: [AddPage(), PendingPage(), Completedpage()]),
      ),
    );
  }
}
