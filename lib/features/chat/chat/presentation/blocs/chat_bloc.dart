import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_messages_stream.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/send_message.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  ChatBloc(
    this._getMessagesStreamUseCase,
    this._sendMessageUseCase,
  ) : super(ChatLoading()) {
    on<GetMessagesStream>(onGetMessagesStream);
    on<SendMessage>(onSendMessage);
  }

  void onGetMessagesStream(GetMessagesStream event, Emitter emit) async {
    emit(ChatLoading());

    final dataState =
        await _getMessagesStreamUseCase(params: event.receiverUniqueUid);

    if (dataState is DataSuccess) {
      await () async {
        await for (final data in dataState.data!) {
          emit(ChatDone(data));
          //if (cancelGetMessagesStream) break;
        }
      }();
    }

    if (dataState is DataFailed) {
      emit(ChatError(dataState.error!));
    }
  }

  void onSendMessage(SendMessage event, Emitter emit) async {
    await _sendMessageUseCase(params: event.sendMessage);
  }
}
