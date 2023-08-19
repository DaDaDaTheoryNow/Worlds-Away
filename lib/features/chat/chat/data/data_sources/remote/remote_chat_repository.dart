import 'package:worlds_away/features/chat/chat/data/models/message.dart';

abstract class RemoteChatRepository {
  Future<Stream<List<MessageModel>>> getMessagesStream(
      String receiverUniqueUid);
}
