import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/data/data_sources/remote/remote_chats_repository.dart';
import 'package:worlds_away/features/chat/chats/data/models/chat.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/chat/chats/domain/repository/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final RemoteChatsRepository _remoteChatsRepository;

  ChatsRepositoryImpl(this._remoteChatsRepository);

  @override
  Future<DataState<Stream<List<ChatModel>>>> getChatsStream() async {
    try {
      final chatsStream = await _remoteChatsRepository.getChatsStream();
      return DataSuccess(chatsStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState> deleteChat(ChatEntity chatEntity) async {
    try {
      await _remoteChatsRepository.deleteChat(ChatModel.fromEntity(chatEntity));
      return DataSuccess(true);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }
}
