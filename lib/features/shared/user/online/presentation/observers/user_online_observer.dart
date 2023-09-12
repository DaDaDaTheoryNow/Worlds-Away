import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class UserOnlineObserver extends WidgetsBindingObserver {
  final FirebaseAuth firebaseAuth;
  UserOnlineObserver(this.firebaseAuth);

  void updateUserOnline(isOnline) {
    final userUniqueUid = firebaseAuth.currentUser?.uid;

    if (userUniqueUid != null) {
      FlutterBackgroundService().invoke(changeUserOnlineBackground,
          {"isOnline": isOnline, "userUniqueUid": userUniqueUid});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateUserOnline(true);
    } else {
      updateUserOnline(false);
    }
  }
}
