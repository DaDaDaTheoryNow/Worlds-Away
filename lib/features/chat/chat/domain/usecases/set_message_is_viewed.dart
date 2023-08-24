import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/repository/chat_repository.dart';

class SetMessagesIsViewedUseCase implements UseCase<void, MessageEntity> {
  final ChatRepository _chatRepository;

  SetMessagesIsViewedUseCase(this._chatRepository);

  @override
  Future<void> call({MessageEntity? params}) async {
    return await _chatRepository.setMessagesIsViewed(params!);
  }
}
