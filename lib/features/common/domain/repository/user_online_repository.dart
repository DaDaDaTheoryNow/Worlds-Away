import 'package:worlds_away/features/common/domain/entities/user_online.dart';

abstract class UserOnlineRepository {
  Future<void> updateUserOnlineStatus(UserOnlineEntity userOnlineEntity);
}
