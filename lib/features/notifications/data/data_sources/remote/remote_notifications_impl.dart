import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:worlds_away/features/notifications/data/data_sources/remote/remote_notifications_repository.dart';

class RemoteNotificationsImpl implements RemoteNotificationsRepository {
  final FirebaseMessaging _firebaseMessaging;

  RemoteNotificationsImpl(this._firebaseMessaging);

  @override
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("Token: $fcmToken");

    final Map<String, String> notificationData = {
      "type": "new_message",
      "senderName": "Kola",
      "messageContent": "Hello",
    };

    Future.delayed(const Duration(seconds: 5), () async {
      await _firebaseMessaging.sendMessage(data: notificationData);
    });
  }
}
