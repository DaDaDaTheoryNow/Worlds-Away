import 'package:equatable/equatable.dart';

import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';

abstract class ChatEvent extends Equatable {
  final SendMessageEntity? sendMessage;

  final String? receiverUniqueUid;

  const ChatEvent({this.receiverUniqueUid, this.sendMessage});

  @override
  List<Object?> get props => [receiverUniqueUid, sendMessage];
}

class GetMessagesStream extends ChatEvent {
  const GetMessagesStream(String receiverUniqueUid)
      : super(receiverUniqueUid: receiverUniqueUid);
}

class SendMessage extends ChatEvent {
  const SendMessage(SendMessageEntity sendMessage)
      : super(sendMessage: sendMessage);
}

class ResetChatState extends ChatEvent {}
