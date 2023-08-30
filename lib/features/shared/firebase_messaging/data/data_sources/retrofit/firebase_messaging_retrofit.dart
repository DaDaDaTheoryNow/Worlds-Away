import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/firebase_messaging/data/models/firebase_notification.dart';

part 'firebase_messaging_retrofit.g.dart';

@RestApi(baseUrl: "https://fcm.googleapis.com")
abstract class FirebaseMessagingRetrofit {
  factory FirebaseMessagingRetrofit(Dio dio) = _FirebaseMessagingRetrofit;

  @POST("/fcm/send")
  @Headers(<String, dynamic>{
    "Authorization": "key=$serverSecretKey",
    "Content-Type": "application/json"
  })
  Future<void> createRequest(
    @Body() FirebaseNotificationModel notification,
  );
}
