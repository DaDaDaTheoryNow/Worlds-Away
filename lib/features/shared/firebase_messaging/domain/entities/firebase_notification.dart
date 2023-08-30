class FirebaseNotificationEntity {
  final String token;
  final String title;
  final String body;

  FirebaseNotificationEntity({
    required this.title,
    required this.body,
    required this.token,
  });
}
