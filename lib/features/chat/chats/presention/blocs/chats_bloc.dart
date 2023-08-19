import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/chat/chats/domain/usecases/get_chats_stream.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_event.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetChatsStreamUseCase _getChatsStreamUseCase;

  ChatsBloc(this._getChatsStreamUseCase) : super(ChatsLoading()) {
    on<GetChatsStream>(onGetChatsStream);
  }

  void onGetChatsStream(GetChatsStream event, Emitter emit) async {
    emit(ChatsLoading());

    final dataState = await _getChatsStreamUseCase();

    if (dataState is DataSuccess) {
      await emit.forEach(dataState.data!, onData: (List<ChatEntity> data) {
        return ChatsDone(data);
      });
    }

    if (dataState is DataFailed) {
      emit(ChatsError(dataState.error!));
    }
  }
}
