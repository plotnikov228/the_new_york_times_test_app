import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initNotifications() {
    var android = const AndroidInitializationSettings('@mipmap/app_icon');
    var IOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var settings = InitializationSettings(android: android, iOS: IOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(settings);
  }

  static Future<void> pushNotification(
      String section, String title, int id) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Background_Notification',
      'Background_Notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
    );
    const IOSNotificationDetails iSODetails = IOSNotificationDetails(
      sound: "default.wav",
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iSODetails);
if(id == 0) {
  await flutterLocalNotificationsPlugin.show(
      0,
      'В рубрике $section была загружена новая статья!',
      title,
      platformChannelSpecifics,
      payload: 'item x');
} else {
  await flutterLocalNotificationsPlugin.show(
      1,
      'Ничего нового',
      'Да',
      platformChannelSpecifics,
      payload: 'item x');
}

    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime;
    androidAllowWhileIdle:
    true;
  }
}
