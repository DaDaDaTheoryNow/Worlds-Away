import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'package:worlds_away/features/chat/chat/data/models/chat_info.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/chat/chat/data/models/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final RemoteChatRepository _remoteChatRepository;

  ChatRepositoryImpl(this._remoteChatRepository);

  @override
  Future<DataState<Stream<ChatInfoModel>>> getChatInfoStream(
      String receiverUniqueUid) async {
    try {
      final messagesStream =
          await _remoteChatRepository.getChatInfoStream(receiverUniqueUid);
      return DataSuccess(messagesStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState> sendMessage(SendMessageEntity messageEntity) async {
    try {
      await _remoteChatRepository
          .sendMessage(SendMessageModel.fromEntity(messageEntity));
      return const DataSuccess(true);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<void> setMessagesIsViewed(MessageEntity messageEntity) async {
    await _remoteChatRepository
        .setMessagesIsViewed(MessageModel.fromEntity(messageEntity));
  }
}
