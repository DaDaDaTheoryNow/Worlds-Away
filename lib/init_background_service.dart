import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:worlds_away/features/shared/user/online/domain/entities/user_online.dart';
import 'package:worlds_away/features/shared/user/online/domain/usecases/update_user_online_status_usecase.dart';
import 'package:worlds_away/injection_container.dart';

import 'core/constants/constants.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  await Firebase.initializeApp();
  await initializeDependencies();

  service.on(changeUserOnlineBackground).listen((event) async {
    final bool isOnline = event!["isOnline"];
    final String userUniqueUid = event["userUniqueUid"];

    final UpdateUserOnlineStatusUseCase updateUserOnlineStatusUseCase =
        sl<UpdateUserOnlineStatusUseCase>();

    await updateUserOnlineStatusUseCase(
        params: UserOnlineEntity(uniqueUid: userUniqueUid, isOnline: isOnline));
  });

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
}

Future<void> initializeService() async {
  final service = sl<FlutterBackgroundService>();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
      initialNotificationTitle: "Worlds Away",
      initialNotificationContent: "Change user online status...",
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
    ),
  );

  await service.startService();
}
