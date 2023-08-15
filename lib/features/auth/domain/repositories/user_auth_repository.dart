import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/resources/user_auth_status_state.dart';

abstract class UserAuthRepository {
  Stream<UserAuthStatusState<User?>> checkUserAuthStatus();
}
