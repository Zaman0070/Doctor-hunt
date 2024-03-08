import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      const DarwinInitializationSettings();
  static void initialize() {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void display(RemoteMessage message) async {
    try {
      // print("In Notification method");
      // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
      Random random = Random();
      int id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            categoryIdentifier: 'plainCategory',
          ),
          android: AndroidNotificationDetails(
        "mychanel",
        "my chanel",
        importance: Importance.max,
        priority: Priority.high,
      ));
      // print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }

  //

  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      '[Utils.requestPermission()] - Permission ${permission.toString()} was already granted';
      return true;
    } else {
      final result = await permission.request();
      if (result == PermissionStatus.granted) {
        '[Utils.requestPermission()] - Permission ${permission.toString()} granted!';
        return true;
      } else {
        '[Utils.requestPermission()] - Permission ${permission.toString()} denied!';
        return false;
      }
    }
  }

  final platformNotificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
      ),
      iOS: DarwinNotificationDetails());

  Future scheduleNotificationDailyCheckList({
    int id = 1,
    String? payLoad,
  }) async {
    var scheduledTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      8,
      30,
    );
    return _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Daily Checklist',
      'Have you completed your daily checklist?',
      tz.TZDateTime.from(
        scheduledTime,
        tz.local,
      ),
      platformNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payLoad,
    );
  }

  Future scheduleNotificationJernal({
    int id = 0,
    String? payLoad,
  }) async {
    var scheduledTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      7,
      30,
    );
    return _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Daily Journal Entry Reminder',
      'Your daily journal entry have ready to fill',
      tz.TZDateTime.from(
        scheduledTime,
        tz.local,
      ),
      platformNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payLoad,
    );
  }
}
