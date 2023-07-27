import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sprint/widgets/my_app.dart';
import 'common/utils/initializer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  Initializer(initServices: () async {}).init(() async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>() !=
        null) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    }

    InitializationSettings initializationSettings;
    if (Platform.isAndroid) {
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
          'high_importance_channel', 'xxxx',
          importance: Importance.max);
      var initializationSettingsAndroid =
          const AndroidInitializationSettings("@mipmap/ic_launcher");
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(channel);

      initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
    } else {
      var initializationSettingsIOS = const DarwinInitializationSettings();
      initializationSettings =
          InitializationSettings(iOS: initializationSettingsIOS);
    }
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      print('notificationnnnnnnn ${notification.title}');

      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            'high_importance_channel', 'xxxx',
            importance: Importance.max,
            playSound: true,
            showProgress: true,
            priority: Priority.high,
            ticker: 'test ticker');

        var iOSChannelSpecifics = const DarwinNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
        // Vibration.vibrate(duration: 1000, amplitude: 128);
        await flutterLocalNotificationsPlugin.show(
            0, notification.title, notification.body, platformChannelSpecifics,
            payload: 'test');
      } else if (Platform.isIOS) {
        var iOSChannelSpecifics = const DarwinNotificationDetails();
        var platformChannelSpecifics =
            NotificationDetails(iOS: iOSChannelSpecifics);
        // Vibration.vibrate(duration: 1000, amplitude: 128);
        await flutterLocalNotificationsPlugin.show(
            0, notification.title, notification.body, platformChannelSpecifics,
            payload: 'test');
      }
    });

    runApp(const MyApp());
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
