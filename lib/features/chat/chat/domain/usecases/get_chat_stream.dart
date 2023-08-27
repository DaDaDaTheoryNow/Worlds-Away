import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/chat_info.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class GetChatInfoStreamUseCase
    implements UseCase<DataState<Stream<ChatInfoEntity>>, String> {
  final ChatRepository _chatRepository;

  GetChatInfoStreamUseCase(this._chatRepository);

  @override
  Future<DataState<Stream<ChatInfoEntity>>> call({String? params}) async {
    return await _chatRepository.getChatInfoStream(params!);
  }
}
