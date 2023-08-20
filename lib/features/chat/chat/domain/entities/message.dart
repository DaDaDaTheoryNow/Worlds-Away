import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class MessageEntity extends Equatable {
  final String? content;
  final Timestamp? timestamp;
  final UserEntity? fromUser;
  final bool? isMy;
  final String? receiverUniqueUid;

  const MessageEntity(
      {this.content,
      this.fromUser,
      this.timestamp,
      this.isMy,
      this.receiverUniqueUid});

  @override
  List<Object?> get props =>
      [content, timestamp, fromUser, isMy, receiverUniqueUid];
}
