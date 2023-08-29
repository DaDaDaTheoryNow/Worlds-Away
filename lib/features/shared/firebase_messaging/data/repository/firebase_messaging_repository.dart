import 'package:dio/dio.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/data_sources/remote/firebase_messaging_service.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/models/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/repository/firebase_messaging_repository.dart';

class FirebaseMessagingRepositoryImpl implements FirebaseMessagingRepository {
  final FirebaseMessagingService _firebaseMessagingService;

  FirebaseMessagingRepositoryImpl(this._firebaseMessagingService);

  @override
  Future<DataState> sendMessageToReceiver(
      FirebaseNotificationEntity firebaseNotificationEntity) async {
    // from entity to  new message
    final FirebaseNotificationModel newNotification =
        FirebaseNotificationModel.fromEntity(firebaseNotificationEntity);

    try {
      await _firebaseMessagingService.createRequest(newNotification);
      return const DataSuccess(true);
    } on DioException catch (e) {
      if (e.response != null) {
        return DataFailed(
            "Error: Отправка сообщения была провалена с кодом: ${e.response!.statusCode}");
      } else {
        return DataFailed(
            "Error: Отправка сообщения была провалена c ошибкой: ${e.error}");
      }
    } catch (e) {
      return DataFailed(
          "Error: Отправка сообщения была провалена c неизвестной ошибкой: $e");
    }
  }
}
