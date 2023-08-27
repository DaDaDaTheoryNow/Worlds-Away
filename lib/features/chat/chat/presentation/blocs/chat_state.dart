import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/chat_info.dart';

class ChatState extends Equatable {
  final ChatInfoEntity? chatInfo;
  final String? error;

  const ChatState({
    this.chatInfo,
    this.error,
  });

  @override
  List<Object?> get props => [chatInfo, error];
}

class ChatLoading extends ChatState {}

class ChatDone extends ChatState {
  const ChatDone(ChatInfoEntity chatInfo) : super(chatInfo: chatInfo);
}

class ChatError extends ChatState {
  const ChatError(String error) : super(error: error);
}
