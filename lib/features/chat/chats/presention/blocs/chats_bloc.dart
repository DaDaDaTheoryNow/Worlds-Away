import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/domain/usecases/get_chats_stream.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_event.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetChatsStreamUseCase _getChatsStreamUseCase;

  ChatsBloc(this._getChatsStreamUseCase) : super(ChatsLoading()) {
    listenMessagesChanges();

    on<GetChatsStream>(onGetChatsStream);
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
