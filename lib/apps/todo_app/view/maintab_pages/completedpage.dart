import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/uitils/widgets/customlisttiles.dart';

import '../../../../services/firebase_services.dart';

class Completedpage extends StatelessWidget{
  const Completedpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:StreamBuilder(
        stream: FirebaseServices.getcompletedtasks(), builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        } else if(snapshot.hasError){
          return Center(child: Text("error"),);
        }else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Task is Completed."),
          );
        }else{
          var data=snapshot.data!.docs;
          return Container(
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => listtilesforcompleted(data[index]),),
          );
        }
      },),
    );
  }
}

