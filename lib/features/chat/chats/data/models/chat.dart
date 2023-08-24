import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required final UserModel user,
      required final String lastMessage,
      required final int messageToNotViewed})
      : super(
            user: user,
            lastMessage: lastMessage,
            messagesToNotViewed: messageToNotViewed);

  factory ChatModel.fromSnapshot(DocumentSnapshot documentSnapshot,
      String lastMessage, int messagesToNotViewed) {
    return ChatModel(
        user: UserModel.fromSnapshot(documentSnapshot),
        lastMessage: lastMessage,
        messageToNotViewed: messagesToNotViewed);
  }
}
