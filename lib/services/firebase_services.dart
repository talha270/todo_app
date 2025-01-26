import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/uitils/const/firebase_const.dart';

class FirebaseServices {
  static final firestore = FirebaseFirestore.instance;

  static getalltasks() {
    return firestore
        .collection(users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(tasks)
        .orderBy("is_completed", descending: false)
        .orderBy("addedat", descending: true)
        .snapshots();
  }

  static addtotask(title, description) {
    var store =
        firestore.collection(users).doc(FirebaseAuth.instance.currentUser!.uid).collection(tasks).doc().set({
      "id": FirebaseAuth.instance.currentUser!.uid,
      "title": title,
      "description": description,
      "is_completed": false,
      "addedat": FieldValue.serverTimestamp(),
      "completedat": null
    });
  }

  static updatetask(title, description, id) {
    var store =
        firestore.collection(users).doc(FirebaseAuth.instance.currentUser!.uid).collection(tasks).doc(id).set({
      "title": title,
      "description": description,
    }, SetOptions(merge: true));
  }

  static updatecomplete(title, description, id, value) {
    var store = firestore
        .collection(users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(tasks)
        .doc(id)
        .set({"is_completed": value,"completedat":FieldValue.serverTimestamp()}, SetOptions(merge: true));
  }

  static getcompletedtasks() {
    return firestore
        .collection(users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(tasks)
        .where("is_completed", isEqualTo: true).orderBy("completedat",descending: true)
        .snapshots();
  }

  static getpendingtasks() {
    return firestore
        .collection(users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(tasks)
        .where("is_completed", isEqualTo: false).orderBy("addedat",descending: true)
        .snapshots();
  }

  static deletetask(id) {
    return firestore
        .collection(users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(tasks)
        .doc(id)
        .delete();
  }


}
