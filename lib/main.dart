import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rinf/rinf.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app.dart';

final FlutterLocalNotificationsPlugin notificationPlugin = FlutterLocalNotificationsPlugin();
const NotificationDetails notificationDetails = NotificationDetails(
  android: AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: BigTextStyleInformation(''),
    visibility: NotificationVisibility.public,
  ),
  iOS: DarwinNotificationDetails(),
);

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: Env.options[defaultTargetPlatform]);
  await setupFlutterNotifications();
  await onMessage(message);
}

Future<void> setupFlutterNotifications() async {
  if (Platform.isAndroid || Platform.isIOS) {
    await [
      FirebaseMessaging.instance.requestPermission(announcement: true, carPlay: true, criticalAlert: true, provisional: true),
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true),
    ].wait;

    const notificationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    final isNotification = await notificationPlugin.initialize(notificationSettings);
    await notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    if (isNotification.elvis) {
      final androidNotificationPlugin = notificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      const notificationChannel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
      );
      await androidNotificationPlugin?.createNotificationChannel(notificationChannel);
    }
  }
}

/*
Android: 포그라운드에서 푸쉬 메시지를 받았을 때 -> 푸쉬 메시지 표시되지 않음 -> 강제로 표시
iOS: 포그라운드에서 푸쉬 메시지를 받았을 때
*/
Future<void> onMessage(RemoteMessage message) async {
  final notification = message.notification;
  if (notification is RemoteNotification && notification.android is AndroidNotification && (Platform.isAndroid || Platform.isIOS)) {
    await notificationPlugin.show(
      0,
      notification.title,
      notification.body,
      notificationDetails,
    );
  }
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await [
    Firebase.initializeApp(options: Env.options[defaultTargetPlatform]),
    Rinf.ensureInitialized(),
  ].wait;
  FirebaseMessaging.onMessage.listen(onMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();

  return runApp(
    App(
      initialRoute: RouteModel.main(),
    ),
  );
}
