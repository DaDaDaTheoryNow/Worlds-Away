import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SendMessageEntity extends Equatable {
  final String? content;
  final Timestamp? timestamp;

  final String? receiverUniqueUid;

  const SendMessageEntity(
      {this.content, this.timestamp, this.receiverUniqueUid});

  @override
  List<Object?> get props => [content, timestamp, receiverUniqueUid];
}
