import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:worlds_away/features/common/domain/entities/user_online.dart';
import 'package:worlds_away/features/common/domain/usecases/update_user_online_status_usecase.dart';

class UserOnlineObserver extends WidgetsBindingObserver {
  final UpdateUserOnlineStatusUseCase _updateUserOnlineStatusUseCase;
  final FirebaseAuth _auth;

  UserOnlineObserver(this._updateUserOnlineStatusUseCase, this._auth);

  Future<void> updateUserOnline(bool isOnline) async {
    final userUniqueUid = _auth.currentUser?.uid;
    if (userUniqueUid != null) {
      await _updateUserOnlineStatusUseCase(
          params:
              UserOnlineEntity(uniqueUid: userUniqueUid, isOnline: isOnline));
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
