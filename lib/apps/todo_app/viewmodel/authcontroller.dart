import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../widgets/customsnackbar.dart';

class Authcontroller extends GetxController {
  var isloadinglogin = false.obs;
  var isloadingsignup = false.obs;
  var ischeck = false.obs;
  var isteacher = true.obs;
  var dropdownbuttonvalue = "Teacher".obs;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<UserCredential?> loginmethod(
      {required String email,
      required String password,
      required context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      customsnackbar("Error in login", e.message.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupmethod(
      {required String email,
      required String password,
      required context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      customsnackbar("Error", e.message.toString());
    }
    return userCredential;
  }

  storeuserdata(
      {required String name,
      required String email,
      required String password,
      required String field}) async {
    DocumentReference store = await firestore
        .collection("account")
        .doc("all")
        .collection(field.toLowerCase())
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({
      "name": name.trim(),
      "email": email.trim(),
      "password": password.trim(),
      "imgurl": "",
      "id": FirebaseAuth.instance.currentUser!.uid,
      "field":field.toLowerCase()
    });
  }
  checkuser(field,email)async{
    final querySnapshot=await firestore.collection("account").doc("all").collection(field).where("email",isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;
  }

}
