import 'package:flutter/material.dart';

class TodoTask {
  String id;
  String title;
  String description;
  String category;
  DateTime reminder;
  int notifID;

  TodoTask({
    @required this.title,
    this.category = 'General',
    this.description = '',
    this.id,
    this.reminder,
    this.notifID,
  });

  static TodoTask fromJson(Map<String, dynamic> json) => TodoTask(
        title: json['title'],
        description: json['description'],
        id: json['id'],
        category: json['category'],
        reminder: DateTime.tryParse(json['reminder']),
        notifID: json['notifID'] != null ? int.tryParse(json['notifID']) : null,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category,
        'id': id,
        'reminder': reminder.toString(),
        'notifID': notifID.toString(),
      };
}
