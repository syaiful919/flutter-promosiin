import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmService {
  final firebaseMessaging = FirebaseMessaging();

  Future<String> getToken() => firebaseMessaging.getToken().then((value) {
        print(">>> inside $value");
        return value;
      });

  void subscribeToTopic(String topic) =>
      firebaseMessaging.subscribeToTopic(topic);

  void unsubscribeFromTopic(String topic) =>
      firebaseMessaging.unsubscribeFromTopic(topic);

  Future<void> configure({
    Future<dynamic> Function(Map<String, dynamic>) onMessage,
    Future<dynamic> Function(Map<String, dynamic>) onResume,
    Future<dynamic> Function(Map<String, dynamic>) onLaunch,
  }) async {
    if (Platform.isIOS) {
      firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true,
          provisional: true,
        ),
      );
      firebaseMessaging.onIosSettingsRegistered.listen((settings) {
        debugPrint('>>> Settings registered: $settings');
      });
    }

    firebaseMessaging.configure(
      onMessage: onMessage,
      onResume: onResume,
      onLaunch: onLaunch,
    );
  }
}
