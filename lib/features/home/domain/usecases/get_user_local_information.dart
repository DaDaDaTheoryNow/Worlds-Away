import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';
import 'package:worlds_away/features/common/domain/entity/user.dart';

class GetUserLocalInformationUseCase implements UseCase<UserEntity, void> {
  final UserSetupRepository _userSetupRepository;

  GetUserLocalInformationUseCase(this._userSetupRepository);

  @override
  Future<UserEntity> call({void params}) async {
    return _userSetupRepository.getUserLocalInformation();
  }
}
