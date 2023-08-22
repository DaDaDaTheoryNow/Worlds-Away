import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:worlds_away/features/common/domain/usecases/update_user_online_status_usecase.dart';

class UserOnlineObserver extends WidgetsBindingObserver {
  final UpdateUserOnlineStatusUseCase _updateUserOnlineStatusUseCase;

  UserOnlineObserver(this._updateUserOnlineStatusUseCase);

  StreamSubscription? connectivityStream;

  Future<void> updateUserOnline(bool isOnline) async {
    await _updateUserOnlineStatusUseCase(params: isOnline);
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
