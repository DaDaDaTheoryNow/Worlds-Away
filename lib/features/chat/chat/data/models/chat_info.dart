import 'package:worlds_away/features/chat/chat/domain/entities/chat_info.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

import 'message.dart';

class ChatInfoModel extends ChatInfoEntity {
  const ChatInfoModel({List<MessageModel>? messages, UserModel? receiverUser})
      : super(messages: messages, receiverUser: receiverUser);
}
