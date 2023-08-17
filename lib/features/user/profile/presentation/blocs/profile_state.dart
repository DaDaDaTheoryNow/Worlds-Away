import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  final Stream<UserEntity>? user;
  final String? error;

  const ProfileState({this.user, this.error});

  @override
  List<Object?> get props => [user, error];
}

class ProfileLoading extends ProfileState {}

class ProfileDone extends ProfileState {
  const ProfileDone(Stream<UserEntity> user) : super(user: user);
}

class ProfileError extends ProfileState {
  const ProfileError(String error) : super(error: error);
}
