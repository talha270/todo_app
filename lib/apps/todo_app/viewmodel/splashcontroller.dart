import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/auth/login.dart';
import 'package:todo_app/main_page.dart';

import 'mainpagecontroller.dart';

class Splashcontroller extends GetxController{
  @override
  void onInit() {
    super.onInit();
    changescreen();
  }
  changescreen() {
    Future.delayed(
      const Duration(seconds: 3),
          () {
        FirebaseAuth.instance.authStateChanges().listen(
              (user) {
            if (user == null) {
              Get.offAll(Loginpage());
            } else {
              Get.put(Mainpagecontroller());
              Get.offAll(MainPage());
            }
          },
        );
      },
    );
  }
}
