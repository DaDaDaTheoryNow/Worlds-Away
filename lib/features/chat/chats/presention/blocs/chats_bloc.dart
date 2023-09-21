import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/domain/usecases/delete_chat.dart';
import 'package:worlds_away/features/chat/chats/domain/usecases/get_chats_stream.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_event.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetChatsStreamUseCase _getChatsStreamUseCase;
  final DeleteChatUseCase _deleteChatUseCase;

  ChatsBloc(this._getChatsStreamUseCase, this._deleteChatUseCase)
      : super(ChatsLoading()) {
    listenMessagesChanges();

    on<GetChatsStream>(onGetChatsStream);
    on<DeleteChat>(onDeleteChat);
  }

  StreamSubscription? chatsStreamSubscription;
  void onGetChatsStream(GetChatsStream event, Emitter emit) async {
    final dataState = event.dataStateChats;

    if (dataState is DataSuccess) {
      emit(ChatsDone(dataState!.data!));
    }

    if (dataState is DataFailed) {
      emit(ChatsError(dataState!.error!));
    }
  }

  void onDeleteChat(DeleteChat event, Emitter emit) async {
    final dataState = await _deleteChatUseCase(params: event.chatEntity);

    // can process
    if (dataState is DataSuccess) {}

    if (dataState is DataFailed) {}
  }

  // stream for listen changes in available chats
  listenMessagesChanges() async {
    final dataState = await _getChatsStreamUseCase();

    if (dataState is DataSuccess) {
      chatsStreamSubscription = dataState.data!.listen((data) {
        add(GetChatsStream(DataSuccess(data)));
      });
    }

    if (dataState is DataFailed) {
      add(GetChatsStream(DataFailed(dataState.error!)));
    }
  }

  @override
  Future<void> close() {
    chatsStreamSubscription?.cancel();

    return super.close();
  }
}
