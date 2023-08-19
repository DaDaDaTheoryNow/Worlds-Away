import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/common/data/models/user.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {String? content, Timestamp? timestamp, UserModel? fromUser, bool? isMy})
      : super(
            content: content,
            timestamp: timestamp,
            fromUser: fromUser,
            isMy: isMy);

  factory MessageModel.fromFirestore(
      Map<String, dynamic> map, UserModel userModel, bool isMy) {
    return MessageModel(
      content: map['userId'],
      timestamp: map['message'],
      fromUser: userModel,
      isMy: isMy,
    );
  }
}
