import 'package:worlds_away/features/common/data/data_sources/remote_user_online_repository.dart';
import 'package:worlds_away/features/common/domain/repository/user_online_repository.dart';

class UserOnlineRepositoryImpl implements UserOnlineRepository {
  final RemoteUserOnlineRepository _remoteUserOnlineRepository;

  UserOnlineRepositoryImpl(this._remoteUserOnlineRepository);

  @override
  Future<void> updateUserOnlineStatus(bool isOnline) async {
    await _remoteUserOnlineRepository.updateUserOnlineStatus(isOnline);
  }
}
