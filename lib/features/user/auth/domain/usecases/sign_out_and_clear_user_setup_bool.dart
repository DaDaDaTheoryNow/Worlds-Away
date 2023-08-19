import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/user/auth/domain/repositories/auth_repository.dart';

class SignInOutAndClearUserSetupBoolUseCase
    implements UseCase<DataState, void> {
  final AuthRepository _authRepository;

  SignInOutAndClearUserSetupBoolUseCase(this._authRepository);

  @override
  Future<DataState> call({void params}) {
    return _authRepository.signOutAndClearUserSetupBool();
  }
}
