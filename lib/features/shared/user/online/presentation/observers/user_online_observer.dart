import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import 'package:worlds_away/core/constants/constants.dart';

class UserOnlineObserver extends WidgetsBindingObserver {
  final FirebaseAuth firebaseAuth;
  UserOnlineObserver(this.firebaseAuth);

  Future<void> updateUserOnline(isOnline) async {
    final userUniqueUid = firebaseAuth.currentUser?.uid;

    if (userUniqueUid != null) {
      print("register one task...");
      await Workmanager().registerOneOffTask(
          (isOnline) ? "online" : "offline", changeUserOnlineBackground,
          inputData: {"isOnline": isOnline, "userUniqueUid": userUniqueUid});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      debugPrint("online on");
      await updateUserOnline(true);
    } else {
      debugPrint("online off");
      await updateUserOnline(false);
    }
  }
}
