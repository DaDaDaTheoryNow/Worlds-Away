import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageEntity> {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  @override
  Future<void> call({SendMessageEntity? params}) async {
    return await _chatRepository.sendMessage(params!);
  }
}
