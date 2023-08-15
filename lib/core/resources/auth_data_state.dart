import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataState<T> {
  final User? user;
  final String? error;

  const AuthDataState({this.error, this.user});
}

class AuthDataSuccess<T> extends AuthDataState<T> {
  const AuthDataSuccess(User? user) : super(user: user);
}

class AuthDataFailed<T> extends AuthDataState<T> {
  const AuthDataFailed(String error) : super(error: error);
}
