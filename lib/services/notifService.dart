import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/models/task.dart';

class NotifService {
  static final NotifService _notifService = NotifService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'TodoApp', 'Todo App Channel', 'Todo Reminder Notifications',
          importance: Importance.high, priority: Priority.high);

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  factory NotifService() {
    return _notifService;
  }

  NotifService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> testNotification(TodoTask todo) async {
    await flutterLocalNotificationsPlugin.show(
      todo.notifID,
      'Reminder to complete your task',
      todo.title,
      platformChannelSpecifics,
    );
  }

  Future<void> scheduleNotification(TodoTask todo) async {
    Duration offsetTime = DateTime.now().timeZoneOffset;
    tz.TZDateTime scheduledTime = tz.TZDateTime.local(
            todo.reminder.year,
            todo.reminder.month,
            todo.reminder.day,
            todo.reminder.hour,
            todo.reminder.minute)
        .subtract(offsetTime);
    print(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.notifID,
        'Reminder to complete your task',
        todo.title,
        scheduledTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future<void> deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
