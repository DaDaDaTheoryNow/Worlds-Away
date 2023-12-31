import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_chat_stream.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/send_message.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/set_message_is_viewed.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/usecases/send_notification_to_receiver.dart';
import 'package:worlds_away/features/shared/user/user/domain/usecases/get_user_information.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatInfoStreamUseCase _chatInfoStreamUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final SetMessagesIsViewedUseCase _setMessageIsViewedUseCase;
  final SendNotificationToReceiverUseCase _sendNotificationToReceiverUseCase;
  final GetUserInformationUseCase _getUserInformationUseCase;
  final String receiverUniqueUid;

  ChatBloc(
    this._chatInfoStreamUseCase,
    this._sendMessageUseCase,
    this._setMessageIsViewedUseCase,
    this._sendNotificationToReceiverUseCase,
    this._getUserInformationUseCase,
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
    final sendMessage = event.sendMessage;

    final sendMessageDataState = await _sendMessageUseCase(params: sendMessage);
    final getUserInformationDataState = await _getUserInformationUseCase();

    if (sendMessageDataState is DataSuccess &&
        getUserInformationDataState is DataSuccess) {
      final firebaseMessagingDataState =
          await _sendNotificationToReceiverUseCase(
              params: FirebaseNotificationEntity(
                  title: getUserInformationDataState.data!.name!,
                  body: sendMessage!.content!,
                  token: sendMessage.toUser!.fcmToken!));

      if (firebaseMessagingDataState is DataSuccess) {
        debugPrint("Success send notification to ${sendMessage.toUser!.name!}");
      } else {
        debugPrint(
            "Failed send notification to ${sendMessage.toUser!.name!}, reason: ${firebaseMessagingDataState.error}");
      }
    }
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
