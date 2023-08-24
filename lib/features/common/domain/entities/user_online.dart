import 'package:equatable/equatable.dart';

class UserOnlineEntity extends Equatable {
  final String uniqueUid;
  final bool isOnline;

  const UserOnlineEntity({
    required this.uniqueUid,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [uniqueUid, isOnline];
}
