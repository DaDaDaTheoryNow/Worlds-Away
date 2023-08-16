import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/resources/auth_data_state.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/local/shared_preferences/local_auth_repository.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/remote/firebase_auth/remote_auth_repository.dart';
import 'package:worlds_away/features/user/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthRepository _firebaseAuthRepository;
  final LocalAuthRepository _localAuthRepository;

  AuthRepositoryImpl(this._firebaseAuthRepository, this._localAuthRepository);

  @override
  Future<AuthDataState<User>> signInWithGoogle() async {
    final User? user = await _firebaseAuthRepository.signInWithGoogle();

    if (user != null) {
      return AuthDataSuccess(user);
    } else {
      return const AuthDataFailed("Вход Был Отменён");
    }
  }

  @override
  Future<AuthDataState> signOutAndClearUserSetupBool() async {
    try {
      await _localAuthRepository.clearUserSetupBool();
      await _firebaseAuthRepository.signOut();
      return const AuthDataSuccess(null);
    } catch (e) {
      return AuthDataFailed(e.toString());
    }
  }
}
