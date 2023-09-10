import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  final String? userUniqueId;

  const ProfileEvent({this.userUniqueId});

  @override
  List<Object?> get props => [userUniqueId];
}

class ChangeAvatar extends ProfileEvent {
  const ChangeAvatar();
}

class GetCurrentUserProfile extends ProfileEvent {}
