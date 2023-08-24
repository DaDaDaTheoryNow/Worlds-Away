import 'package:worlds_away/features/common/data/models/user_online.dart';

abstract class RemoteUserOnlineRepository {
  Future<void> updateUserOnlineStatus(UserOnlineModel userOnlineModel);
}
