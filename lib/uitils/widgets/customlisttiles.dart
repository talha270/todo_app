import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/firebase_services.dart';
import 'package:todo_app/uitils/widgets/alertbox.dart';
import 'package:todo_app/uitils/widgets/show_details.dart';
import 'package:todo_app/uitils/widgets/update_task.dart';

listtilesforaddpage(data) {
  return Card(
    color: Colors.white.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      onTap: () {
        showdetails(data);
      },
      title: Text(data["title"],overflow: TextOverflow.ellipsis,),
      subtitle: Text(data["description"],overflow: TextOverflow.ellipsis,),
      trailing: Icon(data["is_completed"]?Icons.task_alt:Icons.pending,color:  Color(0xFF00246B),),
    ),
  );
}

listtilesforpendingpage(titlecontroller,descriptioncontroller,data) {
  return Card(
    color: Colors.white.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
        onTap: () {
          showdetails(data);
        },
        title: Text(data["title"]),
        subtitle: Text(data["description"]),
        trailing:
        Row(
          mainAxisSize: MainAxisSize.min,
            children: [
          Checkbox(
            value: data["is_completed"],
            onChanged: (value) {
              alertbox(
                message: "Are you completed the task.",
                voidcallback: () {
                  FirebaseServices.updatecomplete(titlecontroller.text, descriptioncontroller.text, data.id,value);
                  Get.back();
                },
              );
            },
          ),
          SizedBox(width: 10,),
          IconButton(onPressed: () {
            updatetask(titlecontroller,descriptioncontroller,data);
          }, icon: Icon(Icons.edit)),
        ])
  ),
  );
}

listtilesforcompleted(data) {
  return Card(
    color: Colors.white.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
        onTap: () {
          showdetails(data);
        },
        title: Text(data["title"],overflow: TextOverflow.ellipsis,),
        subtitle: Text(data["description"],overflow: TextOverflow.ellipsis,),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == "delete") {
              alertbox(
                message: "Are you sure to delete this.",
                voidcallback: () {
                  FirebaseServices.deletetask(data.id);
                  Get.back();
                },
              );
            }
          },
          offset: Offset(-22, 40),
          icon: Icon(
            Icons.more_vert_sharp,
            color: Colors.grey,
            size: 28,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("delete"),
              value: "delete",
            ),
          ],
        )),
  );
}
