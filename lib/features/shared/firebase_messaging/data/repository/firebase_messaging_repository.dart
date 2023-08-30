import 'package:dio/dio.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/data_sources/remote/remote_firebase_messaging_repository.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/data_sources/retrofit/firebase_messaging_retrofit.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/models/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/repository/firebase_messaging_repository.dart';

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  final FirebaseMessagingRetrofit _firebaseMessagingRetrofit;
  final RemoteFirebaseMessagingRepository _remoteFirebaseMessagingRepository;

  FirebaseMessagingRepositoryImpl(
      this._firebaseMessagingRetrofit, this._remoteFirebaseMessagingRepository);

  @override
  Future<DataState> sendNotificationToReceiver(
      FirebaseNotificationEntity firebaseRequestEntity) async {
    // from entity to  new message
    final FirebaseNotificationModel newNotification =
        FirebaseNotificationModel.fromEntity(firebaseRequestEntity);

    try {
      await _firebaseMessagingRetrofit.createRequest(FirebaseNotificationModel(
          title: newNotification.title,
          body: newNotification.body,
          token: newNotification.token));
      return const DataSuccess(true);
    } on DioException catch (e) {
      if (e.response != null) {
        return DataFailed(
            "Error: Отправка сообщения была провалена с кодом: ${e.response}");
      } else {
        return DataFailed(
            "Error: Отправка сообщения была провалена c ошибкой: ${e.error}");
      }
    } catch (e) {
      return DataFailed(
          "Error: Отправка сообщения была провалена c неизвестной ошибкой: $e");
    }
  }

  @override
  Future<DataState> initNotifications() async {
    try {
      await _remoteFirebaseMessagingRepository.initNotifications();
      return const DataSuccess(true);
    } catch (e) {
      return const DataFailed("Error: Ошбика fcm токена");
    }
  }
}
