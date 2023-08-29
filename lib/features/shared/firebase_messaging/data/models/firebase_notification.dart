import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';

class FirebaseNotificationModel {
  final String token;
  final FirebaseNotificationDetailsModel firebaseNotification;

  FirebaseNotificationModel({
    required this.token,
    required this.firebaseNotification,
  });

  factory FirebaseNotificationModel.fromEntity(
      FirebaseNotificationEntity entity) {
    return FirebaseNotificationModel(
      token: entity.token,
      firebaseNotification: FirebaseNotificationDetailsModel.fromEntity(
          entity.firebaseNotification),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'firebaseNotification': firebaseNotification.toJson(),
    };
  }
}

class FirebaseNotificationDetailsModel {
  final String title;
  final String body;

  FirebaseNotificationDetailsModel({
    required this.title,
    required this.body,
  });

  factory FirebaseNotificationDetailsModel.fromEntity(
      FirebaseNotificationDetailsEntity entity) {
    return FirebaseNotificationDetailsModel(
      title: entity.title,
      body: entity.body,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
