import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  final String? receiverUniqueUid;

  const ChatEvent({this.receiverUniqueUid});

  @override
  List<Object?> get props => [receiverUniqueUid];
}

class GetMessagesStream extends ChatEvent {
  const GetMessagesStream(String receiverUniqueUid)
      : super(receiverUniqueUid: receiverUniqueUid);
}
