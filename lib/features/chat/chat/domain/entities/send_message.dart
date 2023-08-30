import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

class SendMessageEntity extends Equatable {
  final String? content;
  final Timestamp? timestamp;

  final UserEntity? toUser;

  const SendMessageEntity({this.content, this.timestamp, this.toUser});

  @override
  List<Object?> get props => [content, timestamp, toUser];
}
