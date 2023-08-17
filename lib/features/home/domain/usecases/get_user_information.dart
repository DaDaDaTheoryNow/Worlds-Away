import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class GetUserInformationUseCase
    implements UseCase<UserInformationDataState<UserEntity?>, void> {
  final UserSetupRepository _userSetupRepository;

  GetUserInformationUseCase(this._userSetupRepository);

  @override
  Future<UserInformationDataState<UserEntity?>> call({void params}) async {
    return _userSetupRepository.getUserInformation();
  }
}
