import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String groupKey = 'com.syaiful.base_project.WORK_EMAIL';
  String groupChannelId = 'grouped channel id';
  String groupChannelName = 'grouped channel name';
  String groupChannelDescription = 'grouped channel description';

  Future<void> initialize({
    Future<dynamic> Function(int, String, String, String)
        onDidReceiveLocalNotification,
    Future<dynamic> Function(String) onSelectNotification,
  }) async {
    try {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
        initializationSettingsAndroid,
        initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: onSelectNotification,
      );
    } catch (e) {
      debugPrint(">>> initialize notification error: $e");
    }
  }

  Future<void> showNotification({
    int id, // must unique, so notifications doesn't overlap
    String title,
    String body,
    String payload,
  }) async {
    try {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        groupChannelId,
        groupChannelName,
        groupChannelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        groupKey: groupKey,
        setAsGroupSummary: true,
      );

      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics,
        payload: payload,
      );
    } catch (e) {
      debugPrint(">>> show local notification error $e");
    }
  }
}
