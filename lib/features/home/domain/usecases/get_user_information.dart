import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class GetUserInformationUseCase
    implements UseCase<DataState<UserEntity?>, void> {
  final UserSetupRepository _userSetupRepository;

  GetUserInformationUseCase(this._userSetupRepository);

  @override
  Future<DataState<UserEntity?>> call({void params}) async {
    return _userSetupRepository.getUserInformation();
  }
}
