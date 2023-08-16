import 'package:firebase_auth/firebase_auth.dart';

import 'package:worlds_away/core/resources/user_auth_status_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';

import 'package:worlds_away/features/user/auth/domain/repositories/user_auth_repository.dart';

class CheckUserAuthStatusUseCase
    implements UseCase<Stream<UserAuthStatusState<User?>>, void> {
  final UserAuthRepository _userAuthRepository;

  CheckUserAuthStatusUseCase(this._userAuthRepository);

  @override
  Future<Stream<UserAuthStatusState<User?>>> call({void params}) async {
    return _userAuthRepository.checkUserAuthStatus();
  }
}
