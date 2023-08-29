class FirebaseNotificationEntity {
  final String token;
  final FirebaseNotificationDetailsEntity firebaseNotification;

  FirebaseNotificationEntity({
    required this.token,
    required this.firebaseNotification,
  });
}

class FirebaseNotificationDetailsEntity {
  final String title;
  final String body;

  FirebaseNotificationDetailsEntity({
    required this.title,
    required this.body,
  });
}
