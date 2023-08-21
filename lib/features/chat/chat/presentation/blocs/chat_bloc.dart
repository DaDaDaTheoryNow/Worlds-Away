import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_messages_stream.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/send_message.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesStreamUseCase _getMessagesStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final String receiverUniqueUid;

  ChatBloc(
    this._getMessagesStreamUseCase,
    this._sendMessageUseCase,
    this.receiverUniqueUid,
  ) : super(ChatLoading()) {
    listenAndAddEmitEventMessages();

    on<GetMessagesStream>(onGetMessagesStream);
    on<SendMessage>(onSendMessage);
  }

  StreamSubscription? messagesStreamSubscription;

  void onGetMessagesStream(GetMessagesStream event, Emitter emit) async {
    final dataState = event.dataStateMessages;

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

  listenAndAddEmitEventMessages() async {
    final dataState =
        await _getMessagesStreamUseCase(params: receiverUniqueUid);

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
    debugPrint("chat bloc closed");
    messagesStreamSubscription!.cancel();
    return super.close();
  }
}
