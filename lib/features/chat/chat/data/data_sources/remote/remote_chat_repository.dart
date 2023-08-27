import 'package:worlds_away/features/chat/chat/data/models/chat_info.dart';
import 'package:worlds_away/features/chat/chat/data/models/message.dart';
import 'package:worlds_away/features/chat/chat/data/models/send_message.dart';

abstract class RemoteChatRepository {
  Future<Stream<ChatInfoModel>> getChatInfoStream(String receiverUniqueUid);

  Future<void> sendMessage(SendMessageModel messageModel);

  Future<void> setMessagesIsViewed(MessageModel messageModel);
}
