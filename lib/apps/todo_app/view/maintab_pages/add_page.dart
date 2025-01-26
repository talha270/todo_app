import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/firebase_services.dart';
import 'package:todo_app/uitils/widgets/addtask.dart';

import '../../../../uitils/widgets/customlisttiles.dart';


class AddPage extends StatelessWidget {
  final titlecontroller=TextEditingController();
  final descriptioncontroller=TextEditingController();
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:StreamBuilder(
        stream: FirebaseServices.getalltasks(), builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        } else if(snapshot.hasError){
          return Center(child: Text("error"),);
        }else if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No Task is added."),
          );
        }else{
          var data=snapshot.data!.docs;
          return Container(
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => listtilesforaddpage(data[index]),
            ),
          );
        }
      },),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addtask(formkey,descriptioncontroller,titlecontroller);
          titlecontroller.clear();
          descriptioncontroller.clear();
        },
        shape: CircleBorder(),
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor:  Color(0xFF00246B),
      ),
    );
  }
}
