import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_messages_stream.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;

  ChatBloc(this._getMessagesStreamUseCase) : super(ChatLoading()) {
    on<GetMessagesStream>(onGetMessagesStream);
  }

  void onGetMessagesStream(GetMessagesStream event, Emitter emit) async {
    emit(ChatLoading());

    final dataState =
        await _getMessagesStreamUseCase.call(params: event.receiverUniqueUid);

    if (dataState is DataSuccess) {
      await emit.forEach(dataState.data!, onData: (List<MessageEntity> data) {
        return ChatDone(data);
      });
    }

    if (dataState is DataFailed) {
      emit(ChatError(dataState.error!));
    }
  }
}
