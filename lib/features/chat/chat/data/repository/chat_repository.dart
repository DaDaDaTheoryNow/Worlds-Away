import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteChatRepository _remoteChatRepository;

  ChatRepositoryImpl(this._remoteChatRepository);

  @override
  Future<DataState<Stream<List<MessageModel>>>> getMessagesStream(
      String receiverUniqueUid) async {
    try {
      final messagesStream =
          await _remoteChatRepository.getMessagesStream(receiverUniqueUid);
      return DataSuccess(messagesStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }
}
