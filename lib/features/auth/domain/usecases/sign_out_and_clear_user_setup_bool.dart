import 'package:worlds_away/core/resources/auth_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/auth/domain/repositories/auth_repository.dart';

class SignInOutAndClearUserSetupBoolUseCase
    implements UseCase<AuthDataState, void> {
  final AuthRepository _authRepository;

  SignInOutAndClearUserSetupBoolUseCase(this._authRepository);

  @override
  Future<AuthDataState> call({void params}) {
    return _authRepository.signOutAndClearUserSetupBool();
  }
}
