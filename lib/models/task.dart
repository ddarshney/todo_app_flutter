import 'package:flutter/material.dart';

class TodoTask {
  String id;
  String title;
  String description;
  String category;
  DateTime reminder;

  TodoTask(
      {@required this.title,
      this.category = 'General',
      this.description = '',
      this.id,
      this.reminder});

  static TodoTask fromJson(Map<String, dynamic> json) => TodoTask(
        title: json['title'],
        description: json['description'],
        id: json['id'],
        category: json['category'],
        reminder: DateTime.fromMillisecondsSinceEpoch(json['reminder']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category,
        'id': id,
        'reminder': reminder.toString(),
      };
}
