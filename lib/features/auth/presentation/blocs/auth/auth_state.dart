import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  final User? user;
  final String? error;

  const AuthState({this.user, this.error});

  @override
  List<Object?> get props => [user, error];
}

class UserSignIn extends AuthState {
  const UserSignIn(User user) : super(user: user);
}

class UserSignOut extends AuthState {
  const UserSignOut();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(String error) : super(error: error);
}
