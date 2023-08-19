import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<DataState<Stream<List<MessageEntity>>>> getMessagesStream(
      String receiverUniqueUid);
}
