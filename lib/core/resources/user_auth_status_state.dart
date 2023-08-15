import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthStatusState<T> {
  final User? user;

  const UserAuthStatusState({this.user});
}

class UserAuthenticated<T> extends UserAuthStatusState<T> {
  const UserAuthenticated(User? user) : super(user: user);
}

class UserUnauthenticated<T> extends UserAuthStatusState<T> {}
