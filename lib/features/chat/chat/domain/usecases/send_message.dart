import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class SendMessageUseCase implements UseCase<DataState, SendMessageEntity> {
  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  @override
  Future<DataState> call({SendMessageEntity? params}) async {
    return await _chatRepository.sendMessage(params!);
  }
}
