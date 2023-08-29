import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/models/firebase_notification.dart';

part 'firebase_messaging_service.g.dart';

@RestApi(baseUrl: "https://fcm.googleapis.com")
abstract class FirebaseMessagingService {
  factory FirebaseMessagingService(Dio dio) = _FirebaseMessagingService;

  @POST("/v1/projects/worlds-away-f4aa1/messages:send")
  @Headers({
    "Authorization": "Bearer $bearerFcmToken",
    "Content-Type": "application/json",
  })
  Future<void> createRequest(
    @Body() FirebaseNotificationModel notification,
  );
}
