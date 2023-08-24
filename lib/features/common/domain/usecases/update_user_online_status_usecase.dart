import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/common/domain/entities/user_online.dart';
import 'package:worlds_away/features/common/domain/repository/user_online_repository.dart';

class UpdateUserOnlineStatusUseCase implements UseCase<void, UserOnlineEntity> {
  final UserOnlineRepository _userOnlineRepository;

  UpdateUserOnlineStatusUseCase(this._userOnlineRepository);

  @override
  Future<void> call({UserOnlineEntity? params}) async {
    return _userOnlineRepository.updateUserOnlineStatus(params!);
  }
}
