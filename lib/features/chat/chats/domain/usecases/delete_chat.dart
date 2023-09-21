import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/chat/chats/domain/repository/chats_repository.dart';

class DeleteChatUseCase implements UseCase<DataState, ChatEntity> {
  final ChatsRepository _chatsRepository;

  DeleteChatUseCase(this._chatsRepository);

  @override
  Future<DataState> call({ChatEntity? params}) async {
    return await _chatsRepository.deleteChat(params!);
  }
}
