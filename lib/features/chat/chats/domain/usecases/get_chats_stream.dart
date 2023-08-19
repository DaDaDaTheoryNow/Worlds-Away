import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/chat/chats/domain/repository/chats_repository.dart';

class GetChatsStreamUseCase
    implements UseCase<DataState<Stream<List<ChatEntity>>>, void> {
  final ChatsRepository _chatsRepository;

  GetChatsStreamUseCase(this._chatsRepository);

  @override
  Future<DataState<Stream<List<ChatEntity>>>> call({void params}) async {
    return await _chatsRepository.getChatsStream();
  }
}
