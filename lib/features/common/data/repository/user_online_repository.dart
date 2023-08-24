import 'package:worlds_away/features/common/data/data_sources/remote_user_online_repository.dart';
import 'package:worlds_away/features/common/data/models/user_online.dart';
import 'package:worlds_away/features/common/domain/entities/user_online.dart';
import 'package:worlds_away/features/common/domain/repository/user_online_repository.dart';

class UserOnlineRepositoryImpl implements UserOnlineRepository {
  final RemoteUserOnlineRepository _remoteUserOnlineRepository;

  UserOnlineRepositoryImpl(this._remoteUserOnlineRepository);

  @override
  Future<void> updateUserOnlineStatus(UserOnlineEntity userOnlineEntity) async {
    await _remoteUserOnlineRepository
        .updateUserOnlineStatus(UserOnlineModel.fromEntity(userOnlineEntity));
  }
}
