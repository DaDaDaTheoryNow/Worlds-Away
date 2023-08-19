import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class GetMessagesStreamUseCase
    implements UseCase<DataState<Stream<List<MessageEntity>>>, String> {
  final ChatRepository _chatRepository;

  GetMessagesStreamUseCase(this._chatRepository);

  @override
  Future<DataState<Stream<List<MessageEntity>>>> call({String? params}) async {
    return await _chatRepository.getMessagesStream(params!);
  }
}
