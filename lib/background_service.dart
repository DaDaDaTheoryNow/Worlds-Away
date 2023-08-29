import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BackgroundService {
  final FirebaseFirestore _firestore;
  final FlutterBackgroundService _service;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  const BackgroundService(
      this._firestore, this._flutterLocalNotificationsPlugin, this._service);

  // this will be used as notification channel id
  static const notificationChannelId = 'worlds_away_foreground';

// this will be used for notification id, So you can update your custom notification with this id.
  static const notificationId = 888;

  Future<void> initializeService() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      'Worlds Away FOREGROUND SERVICE',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: (instance) =>
            onStart(instance, _firestore, _flutterLocalNotificationsPlugin),
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: (instance) =>
            onStart(instance, _firestore, _flutterLocalNotificationsPlugin),
        onBackground: null,
      ),
    );
    _service.startService();
  }

  static Future<void> onStart(ServiceInstance service, firestoreStatic,
      flutterLocalNotificationsPluginStatic) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    String oldValue = "";

    // bring to foreground
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          await Firebase.initializeApp();
          firestoreStatic
              .collection("users")
              .doc("test")
              .snapshots()
              .listen((snapshot) {
            if (snapshot.exists) {
              final data = snapshot.data() as Map<String, dynamic>;
              final id = data["id"];

              if (oldValue != id) {
                flutterLocalNotificationsPluginStatic.show(
                  notificationId,
                  'Worlds Away',
                  'Data changed: ID $id',
                  const NotificationDetails(
                    android: AndroidNotificationDetails(
                      notificationChannelId,
                      'MY FOREGROUND SERVICE',
                      icon: 'ic_bg_service_small',
                      ongoing: true,
                    ),
                  ),
                );
              }

              oldValue = id;
            }
          });
        }
      }
    });
  }
}
