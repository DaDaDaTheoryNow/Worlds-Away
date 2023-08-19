import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/resources/data_state.dart';

abstract class AuthRepository {
  Future<DataState<User>> signInWithGoogle();
  Future<DataState> signOutAndClearUserSetupBool();
}
