import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';

class GetUserSetupStateUseCase implements UseCase<UserSetupDataState, void> {
  final UserSetupRepository _initSetupRepository;

  GetUserSetupStateUseCase(this._initSetupRepository);

  @override
  Future<UserSetupDataState> call({void params}) async {
    return _initSetupRepository.getUserSetupState();
  }
}
