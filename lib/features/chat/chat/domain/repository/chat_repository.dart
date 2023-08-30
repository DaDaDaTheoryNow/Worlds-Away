import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/chat_info.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';

abstract class ChatRepository {
  Future<DataState<Stream<ChatInfoEntity>>> getChatInfoStream(
      String receiverUniqueUid);

  Future<DataState> sendMessage(SendMessageEntity messageEntity);

  Future<void> setMessagesIsViewed(MessageEntity messageEntity);
}
