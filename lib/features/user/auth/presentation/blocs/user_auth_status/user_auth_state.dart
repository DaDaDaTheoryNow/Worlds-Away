import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserAuthStatus { authenticated, unauthenticated, unknown }

class UserAuthState extends Equatable {
  final UserAuthStatus? status;
  final User? user;

  const UserAuthState({this.user, this.status});

  @override
  List<Object?> get props => [user, status];
}
