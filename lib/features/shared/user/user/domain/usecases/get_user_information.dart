import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';
import 'package:worlds_away/features/shared/user/user/domain/repository/user_repository.dart';

class GetUserInformationUseCase
    implements UseCase<DataState<UserEntity?>, void> {
  final UserRepository _userSetupRepository;

  GetUserInformationUseCase(this._userSetupRepository);

  @override
  Future<DataState<UserEntity?>> call({void params}) async {
    return _userSetupRepository.getUserInformation();
  }
}
