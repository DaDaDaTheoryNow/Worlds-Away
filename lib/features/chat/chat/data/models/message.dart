import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {String? content,
      Timestamp? timestamp,
      UserModel? fromUser,
      bool? isMy,
      bool? isViewed,
      String? receiverUniqueUid})
      : super(
            content: content,
            timestamp: timestamp,
            fromUser: fromUser,
            isMy: isMy,
            isViewed: isViewed,
            receiverUniqueUid: receiverUniqueUid);

  factory MessageModel.fromFirestore(Map<String, dynamic> map,
      UserModel userModel, bool isMy, String receiverUniqueUid) {
    return MessageModel(
        content: map['content'],
        timestamp: map['timestamp'],
        fromUser: userModel,
        isMy: isMy,
        isViewed: map["isViewed"],
        receiverUniqueUid: receiverUniqueUid);
  }

  factory MessageModel.fromEntity(MessageEntity messageEntity) {
    return MessageModel(
      content: messageEntity.content,
      timestamp: messageEntity.timestamp,
      fromUser: UserModel.fromEntity(messageEntity.fromUser!),
      isMy: messageEntity.isMy,
      isViewed: messageEntity.isViewed,
      receiverUniqueUid: messageEntity.receiverUniqueUid,
    );
  }
}
