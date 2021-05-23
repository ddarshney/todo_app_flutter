import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/dbService.dart';

class TaskTile extends StatelessWidget {
  final TodoTask todoTask;

  TaskTile({this.todoTask});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.todoTask.id),
      onDismissed: (direction) {
        DBService myDB =
            DBService(userID: FirebaseAuth.instance.currentUser.uid);
        myDB.deleteTodo(this.todoTask);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 5,
              color: Colors.black.withOpacity(0.2),
            )
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    )),
                child: Row(
                  children: [
                    getIconBox(this.todoTask.category),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.todoTask.title ?? 'Untitled Todo',
                            style: GoogleFonts.hammersmithOne(
                                textStyle: TextStyle(fontSize: 22)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: getColor(this.todoTask.category)
                                    .withOpacity(0.9)),
                            child: Padding(
                              padding: const EdgeInsets.all(9.0),
                              child: Text(
                                this.todoTask.category,
                                style: GoogleFonts.hammersmithOne(
                                    textStyle: TextStyle(
                                        fontSize: 17, color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color getColor(String category) {
  if (category == 'Personal') {
    return Colors.red[400];
  }
  if (category == 'Work') {
    return Colors.purple[400];
  }
  return Colors.blue[700];
}

Container getIconBox(String category) {
  Icon myicon;
  if (category == 'Personal') {
    myicon = Icon(Icons.person);
  } else if (category == 'Work') {
    myicon = Icon(Icons.work);
  } else
    myicon = Icon(Icons.check_box_outline_blank_outlined);
  Color myColor = getColor(category);
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        blurRadius: 24,
        spreadRadius: 16,
        color: Colors.white.withOpacity(0.5),
      )
    ]),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            myicon.icon,
            size: 40,
            color: myColor,
          ),
        ),
      ),
    ),
  );
}
