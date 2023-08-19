import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';

abstract class ChatsState extends Equatable {
  final List<ChatEntity>? chats;
  final String? error;

  const ChatsState({this.chats, this.error});

  @override
  List<Object?> get props => [chats, error];
}

class ChatsLoading extends ChatsState {}

class ChatsDone extends ChatsState {
  const ChatsDone(List<ChatEntity> chats) : super(chats: chats);
}

class ChatsError extends ChatsState {
  const ChatsError(String error) : super(error: error);
}
