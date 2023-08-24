import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';

abstract class ChatRepository {
  Future<DataState<Stream<List<MessageEntity>>>> getMessagesStream(
      String receiverUniqueUid);

  Future<void> sendMessage(SendMessageEntity messageEntity);

  Future<void> setMessagesIsViewed(MessageEntity messageEntity);
}
