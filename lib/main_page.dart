import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/apps/chatting/chating_main.dart';
import 'package:todo_app/apps/ecom_app/ecom_main.dart';
import 'package:todo_app/apps/time_table/view/different_classes.dart';
import 'package:todo_app/apps/todo_app/view/maintab_page.dart';
import 'package:todo_app/auth/login.dart';
import 'package:todo_app/uitils/widgets/customtext.dart';

import 'package:todo_app/widgets/mainpage_cards.dart';

import 'apps/todo_app/viewmodel/mainpagecontroller.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final controller = Get.find<Mainpagecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.93),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: Image.asset("assets/images/person.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => customtext(
                              text: "Hi ${controller.username.value}👋",
                              size: 20,
                              wiegth: FontWeight.bold),
                        ),
                        customtext(
                            text: "Welcome Back",
                            size: 15,
                            wiegth: FontWeight.bold),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAll(Loginpage());
                        },
                        icon: Icon(Icons.logout))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 80),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return mainpagecard(
                        color: Color(0xFF00246B),
                        callback: () {
                          index==0?Get.to(MaintabPage()):index==1? Get.to(DifferentClasses()):index==2?Get.to(EcomMain()):Get.to(ChatingMain());
                        },
                        subtitle: controller.carddata[index]["subtitle"].toString(),
                        icon: Icon(index==0?Icons.add_task:index==1?Icons.timelapse:index==2?Icons.store:Icons.chat,size: 25,color: Colors.white.withOpacity(0.7),),
                        title: controller.carddata[index]["title"].toString());
                  },
                ),
                customtext(
                    text: "Exclusive Offers ",
                    size: 18,
                    wiegth: FontWeight.bold),
                SizedBox(
                  height: 10,
                ),
                 ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 20,
                      color: Colors.white70,
                      child: ListTile(
                          title: customtext(
                              text: "Product Name",
                              size: 15,
                              wiegth: FontWeight.bold),
                          subtitle:
                              customtext(text: "Price: 100\$-200\$", size: 13),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage("assets/images/product.png"),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_rounded))),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
