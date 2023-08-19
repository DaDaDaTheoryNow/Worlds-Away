import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

class ChatState extends Equatable {
  final List<MessageEntity>? messages;
  final String? error;

  const ChatState({this.messages, this.error});

  @override
  List<Object?> get props => [messages, error];
}

class ChatLoading extends ChatState {}

class ChatDone extends ChatState {
  const ChatDone(List<MessageEntity> messages) : super(messages: messages);
}

class ChatError extends ChatState {
  const ChatError(String error) : super(error: error);
}
