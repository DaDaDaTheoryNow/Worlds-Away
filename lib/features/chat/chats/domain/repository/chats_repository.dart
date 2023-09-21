import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';

abstract class ChatsRepository {
  Future<DataState<Stream<List<ChatEntity>>>> getChatsStream();
  Future<DataState> deleteChat(ChatEntity chatEntity);
}
