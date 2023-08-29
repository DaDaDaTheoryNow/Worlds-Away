import 'package:equatable/equatable.dart';

import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

import 'message.dart';

class ChatInfoEntity extends Equatable {
  final List<MessageEntity>? messages;
  final UserEntity? receiverUser;

  const ChatInfoEntity({this.messages, this.receiverUser});

  @override
  List<Object?> get props => [messages, receiverUser];
}
