import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class UsersEntity extends Equatable {
  final List<UserEntity>? usersList;

  const UsersEntity({this.usersList});

  @override
  List<Object?> get props => [usersList];
}
