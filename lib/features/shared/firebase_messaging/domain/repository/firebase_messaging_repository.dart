import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';

abstract class FirebaseMessagingRepository {
  Future<DataState> initNotifications();
  Future<DataState> sendNotificationToReceiver(
      FirebaseNotificationEntity firebaseNotificationEntity);
}
