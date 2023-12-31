import 'package:equatable/equatable.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';

abstract class ChatsEvent extends Equatable {
  final DataState<List<ChatEntity>>? dataStateChats;

  final ChatEntity? chatEntity;

  const ChatsEvent({this.dataStateChats, this.chatEntity});

  @override
  List<Object?> get props => [dataStateChats];
}

class GetChatsStream extends ChatsEvent {
  const GetChatsStream(DataState<List<ChatEntity>> dataStateChats)
      : super(dataStateChats: dataStateChats);
}

class DeleteChat extends ChatsEvent {
  const DeleteChat(ChatEntity chatEntity) : super(chatEntity: chatEntity);
}
