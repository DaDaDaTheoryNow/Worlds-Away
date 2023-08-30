import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';

class FirebaseNotificationModel {
  final String token;
  final String title;
  final String body;

  FirebaseNotificationModel(
      {required this.title, required this.body, required this.token});

  Map<String, dynamic> toJson() {
    return {
      "to": token,
      "notification": {"title": title, "body": body},
    };
  }

  factory FirebaseNotificationModel.fromEntity(
      FirebaseNotificationEntity entity) {
    return FirebaseNotificationModel(
        title: entity.title, body: entity.body, token: entity.token);
  }
}
