import 'package:worlds_away/features/shared/user/online/data/data_sources/remote_user_online_repository.dart';
import 'package:worlds_away/features/shared/user/online/data/models/user_online.dart';
import 'package:worlds_away/features/shared/user/online/domain/entities/user_online.dart';
import 'package:worlds_away/features/shared/user/online/domain/repository/user_online_repository.dart';

class UserOnlineRepositoryImpl implements UserOnlineRepository {
  final RemoteUserOnlineRepository _remoteUserOnlineRepository;

  UserOnlineRepositoryImpl(this._remoteUserOnlineRepository);

  @override
  Future<void> updateUserOnlineStatus(UserOnlineEntity userOnlineEntity) async {
    await _remoteUserOnlineRepository
        .updateUserOnlineStatus(UserOnlineModel.fromEntity(userOnlineEntity));
  }
}
