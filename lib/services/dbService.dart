import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
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
        title: mytodo.title,
        subtitle: mytodo.category,
        id: doc.id,
      );
    }).toList();
  }

  void deleteTodo(String id) {
    db
        .collection(userID)
        .doc(id)
        .delete()
        .then((value) => print("Deleted document"));
  }

  void createTodo(TodoTask todo) {
    if (todo == null) {
      todo = TodoTask(title: 'New Todo');
    }

    String docID;
    db.collection(userID).add(todo.toJson()).then((documentReference) {
      print('${documentReference.id}');
      db
          .collection(userID)
          .doc(documentReference.id)
          .update({'id': documentReference.id});
    });
  }
}
