import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String? fcmToken;

class Fcm {
  //function for main
  static Future<void> fireBaseNotifications() async {
    await FirebaseMessaging.instance.requestPermission();
    fcmToken = await FirebaseMessaging.instance.getToken().then((value) {
      print("Device Token: $value");
      return value;
    });
    //Todo : Save toekn in firebase

    initPushNotifications();
  }

  //-----------------------------------------------------------------------
  static Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //for background and terminate app listen message
    FirebaseMessaging.onBackgroundMessage((message) {
      return backgroundFCM(message);
    });
    //for foreground listen message
    FirebaseMessaging.onMessage.listen((message) async {
      foreGroundAppFCM(message);
    });
  }

  static Future<void> foreGroundAppFCM(RemoteMessage event) async {
    String title = event.notification!.title.toString();
    String body = event.notification!.body.toString();

    print("-----OnForegroundApp---$title");
    print("----OnForegroundApp---$body");

    await displayNotification(
        title: title.toString(), body: body.toString(), remoteMessage: event);

    // Store the notification data in Firestore
    // await FirebaseFirestore.instance.collection('notifications').add({
    //   'title': title,
    //   'body': body,
    //   'timestamp': FieldValue.serverTimestamp(),
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp
  }

  static backgroundFCM(RemoteMessage message) async {
    print("FCM background message");

    var title = message.notification?.title;
    var body = message.notification?.body;
    print("-----On_background/OnTerminated ---$title");
    print("----On_background/OnTerminated---$body");
    print("----On_background/OnTerminated--[payload]:${message.data}");

    displayNotification(
        title: title.toString(), body: body.toString(), remoteMessage: message);

    // await FirebaseFirestore.instance.collection('notifications').add({
    //   'title': title,
    //   'body': body,
    //   'timestamp': FieldValue.serverTimestamp(),
    // });
  }

  static Future<void> displayNotification({
    required RemoteMessage remoteMessage,
    required String title,
    required String body,
  }) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          defaultPresentSound: true,
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (
            int? id,
            String? title,
            String? body,
            String? payload,
          ) async {
            print('Received notification in the foreground:');
            print('ID: $id, Title: $title, Body: $body, Payload: $payload');

            print('Payload: $payload');
          },
        ),
      ),
    );

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "test_channel",
          "Test Channel",
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: 'custom_payload', // Add a custom payload if needed
    );
  }
}
