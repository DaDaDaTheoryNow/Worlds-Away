import 'package:worlds_away/features/shared/user/online/domain/entities/user_online.dart';

abstract class UserOnlineRepository {
  Future<void> updateUserOnlineStatus(UserOnlineEntity userOnlineEntity);
}
