import 'package:firebase_auth/firebase_auth.dart';

import 'package:worlds_away/core/resources/user_auth_status_state.dart';

import 'package:worlds_away/features/user/auth/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const UserAuthRepositoryImpl(this._firebaseAuth);

  @override
  Stream<UserAuthStatusState<User?>> checkUserAuthStatus() {
    return _firebaseAuth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserAuthenticated(user);
      } else {
        return UserUnauthenticated();
      }
    });
  }
}
