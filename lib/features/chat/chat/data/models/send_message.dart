import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';

class SendMessageModel extends MessageEntity {
  const SendMessageModel(
      {String? content, Timestamp? timestamp, String? receiverUniqueUid})
      : super(
            content: content,
            timestamp: timestamp,
            receiverUniqueUid: receiverUniqueUid);

  factory SendMessageModel.fromEntity(SendMessageEntity sendMessageEntity) {
    return SendMessageModel(
      content: sendMessageEntity.content,
      timestamp: sendMessageEntity.timestamp,
      receiverUniqueUid: sendMessageEntity.toUser!.uniqueUid,
    );
  }
}
