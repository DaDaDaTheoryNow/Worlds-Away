import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/resources/data_state.dart';

import 'package:worlds_away/features/user/auth/data/data_sources/local/shared_preferences/local_auth_repository.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/remote/firebase_auth/remote_auth_repository.dart';
import 'package:worlds_away/features/user/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthRepository _firebaseAuthRepository;
  final LocalAuthRepository _localAuthRepository;

  AuthRepositoryImpl(this._firebaseAuthRepository, this._localAuthRepository);

  @override
  Future<DataState<User>> signInWithGoogle() async {
    final User? user = await _firebaseAuthRepository.signInWithGoogle();

    if (user != null) {
      return DataSuccess(user);
    } else {
      return const DataFailed("Вход Был Отменён");
    }
  }

  @override
  Future<DataState> signOutAndClearUserSetupBool() async {
    try {
      await _localAuthRepository.clearUserSetupBool();
      await _firebaseAuthRepository.signOut();
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
