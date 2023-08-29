import 'package:worlds_away/features/shared/user/online/data/models/user_online.dart';

abstract class RemoteUserOnlineRepository {
  Future<void> updateUserOnlineStatus(UserOnlineModel userOnlineModel);
}
