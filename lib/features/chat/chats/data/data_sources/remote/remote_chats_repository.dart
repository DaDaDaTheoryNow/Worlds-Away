import 'package:worlds_away/features/chat/chats/data/models/chat.dart';

abstract class RemoteChatsRepository {
  Future<Stream<List<ChatModel>>> getChatsStream();
}
