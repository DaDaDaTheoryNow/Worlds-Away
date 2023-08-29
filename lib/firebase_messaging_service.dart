import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService123 {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessagingService123(this._firebaseMessaging);

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic("test");

    print("Token: $fcmToken");
  }
}
