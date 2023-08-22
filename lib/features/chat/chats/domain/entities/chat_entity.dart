import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class ChatEntity extends Equatable {
  final UserEntity user;
  final String lastMessage;
  // final int messagesToNotViewed

  const ChatEntity({required this.user, required this.lastMessage});

  @override
  List<Object?> get props => [user, lastMessage];
}
