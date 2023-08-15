import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/resources/auth_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<AuthDataState<User>, void> {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  @override
  Future<AuthDataState<User>> call({void params}) {
    return _authRepository.signInWithGoogle();
  }
}
