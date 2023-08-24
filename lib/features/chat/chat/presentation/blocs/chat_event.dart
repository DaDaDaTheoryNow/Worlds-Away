import 'package:equatable/equatable.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';

abstract class ChatEvent extends Equatable {
  final MessageEntity? messageEntity;
  final SendMessageEntity? sendMessage;
  final DataState<List<MessageEntity>>? dataStateMessages;

  final String? receiverUniqueUid;

  const ChatEvent(
      {this.receiverUniqueUid,
      this.sendMessage,
      this.dataStateMessages,
      this.messageEntity});

  @override
  List<Object?> get props =>
      [receiverUniqueUid, sendMessage, messageEntity, dataStateMessages];
}

class GetMessagesStream extends ChatEvent {
  const GetMessagesStream(DataState<List<MessageEntity>> dataStateMessages)
      : super(dataStateMessages: dataStateMessages);
}

class SendMessage extends ChatEvent {
  const SendMessage(SendMessageEntity sendMessage)
      : super(sendMessage: sendMessage);
}

class SetMessagesIsViewed extends ChatEvent {
  const SetMessagesIsViewed(MessageEntity messageEntity)
      : super(messageEntity: messageEntity);
}
