import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_chat_stream.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/set_message_is_viewed.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatInfoStreamUseCase _chatInfoStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SetMessagesIsViewedUseCase _setMessageIsViewedUseCase;
  final String receiverUniqueUid;

  ChatBloc(
    this._chatInfoStreamUseCase,
    this._sendMessageUseCase,
    this._setMessageIsViewedUseCase,
    this.receiverUniqueUid,
  ) : super(ChatLoading()) {
    listenMessagesChanges();

    on<GetMessagesStream>(onGetMessagesStream);
    on<SendMessage>(onSendMessage);
    on<SetMessagesIsViewed>(onSetMessagesIsViewed);
  }

  StreamSubscription? messagesStreamSubscription;

  void onGetMessagesStream(GetMessagesStream event, Emitter emit) async {
    final dataState = event.dataStateMessagesAndReceiverUser;

    if (dataState is DataSuccess) {
      emit(ChatDone(dataState!.data!));
    }

    if (dataState is DataFailed) {
      emit(ChatError(dataState!.error!));
    }
  }

  void onSendMessage(SendMessage event, Emitter emit) async {
    await _sendMessageUseCase(params: event.sendMessage);
  }

  void onSetMessagesIsViewed(SetMessagesIsViewed event, Emitter emit) async {
    await _setMessageIsViewedUseCase(params: event.messageEntity);
  }

  listenMessagesChanges() async {
    final dataState = await _chatInfoStreamUseCase(params: receiverUniqueUid);

    if (dataState is DataSuccess) {
      messagesStreamSubscription = dataState.data!.listen((data) {
        add(GetMessagesStream(DataSuccess(data)));
      });
    }

    if (dataState is DataFailed) {
      add(GetMessagesStream(DataFailed(dataState.error!)));
    }
  }

  @override
  Future<void> close() {
    messagesStreamSubscription?.cancel();
    return super.close();
  }
}
