import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'package:worlds_away/features/shared/user/online/domain/entities/user_online.dart';
import 'package:worlds_away/features/shared/user/online/domain/usecases/update_user_online_status_usecase.dart';
import 'package:worlds_away/injection_container.dart';

import 'core/constants/constants.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp();
    await initializeDependencies();

    switch (task) {
      case changeUserOnlineBackground:
        final bool isOnline = inputData!["isOnline"];
        final String userUniqueUid = inputData["userUniqueUid"];

        final UpdateUserOnlineStatusUseCase updateUserOnlineStatusUseCase =
            sl<UpdateUserOnlineStatusUseCase>();

        await updateUserOnlineStatusUseCase(
            params:
                UserOnlineEntity(uniqueUid: userUniqueUid, isOnline: isOnline));
    }

    return Future.value(true);
  });
}
