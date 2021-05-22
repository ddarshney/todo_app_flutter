import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/dbService.dart';

class AddTask extends StatefulWidget {
  final DBService myDB;
  AddTask({this.myDB});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String timePickerText = 'Reminder';
  String _selectedCategory = null;
  DateTime pickedTime;
  List<String> _categories = ['General', 'Personal', 'Work'];
  List<Color> border = [Colors.black, Colors.transparent, Colors.transparent];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.cyan[50].withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 500,
            // width: MediaQuery.of(context).size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Text(
                    //   'Title',
                    //   style: GoogleFonts.kanit(
                    //       textStyle: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 25,
                    //           fontWeight: FontWeight.bold)),
                    // ),
                    TextField(
                      controller: titleController,
                      autofocus: false,
                      style: GoogleFonts.hammersmithOne(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          labelText: "Title",
                          prefixIcon: Icon(Icons.check),
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    TextField(
                      controller: descriptionController,
                      autofocus: false,
                      style: GoogleFonts.hammersmithOne(
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      decoration: InputDecoration(
                          labelText: "Description",
                          prefixIcon: Icon(Icons.bookmark),
                          labelStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _selectedCategory,
                            hint: Text(
                              'Category',
                              style: GoogleFonts.hammersmithOne(
                                color: Colors.black,
                              ),
                            ),
                            items: _categories
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e,
                                        style: GoogleFonts.hammersmithOne(
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                _selectedCategory = newValue;
                                print('category = $newValue');
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        pickedTime = await selectDateTime(context);
                        if (pickedTime != null) {
                          setState(() {
                            timePickerText =
                                DateFormat.yMMMMd().add_jm().format(pickedTime);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(timePickerText,
                              style: GoogleFonts.hammersmithOne(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(40, 3, 230, 1),
                      ),
                      onPressed: () async {
                        TodoTask newTodo = TodoTask(
                          title: titleController.text.trim(),
                          category: _selectedCategory,
                          description: descriptionController.text.trim(),
                          reminder: pickedTime,
                          notifID: widget.myDB.getNotificationID(),
                        );
                        widget.myDB.createTodo(newTodo);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Add Task",
                        style: GoogleFonts.hammersmithOne(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    )
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

Future<DateTime> selectDateTime(BuildContext context) async {
  return DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2030), onChanged: (date) {
    String time = DateFormat.yMMMMd().add_jm().format(date);
    print("Changed to $time");
  });
}
