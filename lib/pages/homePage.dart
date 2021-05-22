import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/pages/addTask.dart';
import 'package:todo_app/services/authService.dart';
import 'package:todo_app/services/dbService.dart';
import 'package:todo_app/widgets/taskTile.dart';

class HomePage extends StatelessWidget {
  final DBService myDB =
      DBService(userID: FirebaseAuth.instance.currentUser.uid);
  @override
  Widget build(BuildContext context) {
    print("BUILD AGAIN!!!!!");
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.jpg')),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Container(
                  color: Colors.blue[400].withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Your Tasks',
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: Colors.blue[2000],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: myDB.tasksSnaps,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              print('CAME HERE');
                              List<TaskTile> todoListTiles =
                                  myDB.taskList(snapshot.data);
                              if (todoListTiles.length == 0) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('You have no tasks left!',
                                          style: GoogleFonts.kanit(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SvgPicture.asset(
                                          'assets/images/completed.svg',
                                          width: 300),
                                    ],
                                  ),
                                );
                              }
                              return ListView(
                                children: todoListTiles,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
      // body:
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 50,
        ),
        backgroundColor: Colors.black,
        onPressed: () async {
          showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.3),
              builder: (context) {
                return AddTask(
                  myDB: myDB,
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
