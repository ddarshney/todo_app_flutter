import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notifService.dart';
import 'package:todo_app/widgets/taskTile.dart';

class DBService {
  String userID;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<QuerySnapshot> get tasksSnaps => db.collection(userID).snapshots();
  DBService({@required this.userID});

  List<TaskTile> taskList(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      if (doc.data() == null) {
        print('NULL DATA');
        //   return Container();
      }
      TodoTask mytodo = TodoTask.fromJson(doc.data());
      return TaskTile(
        todoTask: mytodo,
      );
    }).toList();
  }

  void deleteTodo(TodoTask todo) {
    db
        .collection(userID)
        .doc(todo.id)
        .delete()
        .then((value) => print("Deleted document"));
    if (todo.reminder != null) {
      NotifService().deleteNotification(todo.notifID);
    }
  }

  int getNotificationID() {
    DateTime myTime = DateTime.now();
    String id = myTime.month.toString() +
        myTime.day.toString() +
        myTime.hour.toString() +
        myTime.minute.toString() +
        myTime.second.toString();
    return int.parse(id);
  }

  void createTodo(TodoTask todo) {
    if (todo == null) {
      todo = TodoTask(title: 'New Todo');
    }
    db.collection(userID).add(todo.toJson()).then((documentReference) {
      print('${documentReference.id}');
      db
          .collection(userID)
          .doc(documentReference.id)
          .update({'id': documentReference.id});
    });
    NotifService().testNotification(todo);
  }
}
