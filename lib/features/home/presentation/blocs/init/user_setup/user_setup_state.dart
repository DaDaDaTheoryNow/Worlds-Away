import 'package:equatable/equatable.dart';

enum UserSetupStatus { filled, empty }

class UserSetupState extends Equatable {
  final String? photoUrl;
  final UserSetupStatus? status;
  final String? error;

  const UserSetupState({this.error, this.status, this.photoUrl});

  @override
  List<Object?> get props => [status, error, photoUrl];
}

class UserSetupLoading extends UserSetupState {}

class UserSetupError extends UserSetupState {
  const UserSetupError(String error) : super(error: error);
}
