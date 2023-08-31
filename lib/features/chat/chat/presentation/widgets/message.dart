import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';

import 'chat.dart';

class MessageWidget extends StatelessWidget {
  final MessageEntity message;
  const MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!message.isViewed!) {
        _onMessageViewed(context, message);
      }
    });

    final alignment =
        message.isMy! ? Alignment.centerRight : Alignment.centerLeft;

    final crossAlignment =
        message.isMy! ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor = message.isMy! ? Colors.blue : Colors.grey;

    return Align(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: crossAlignment,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 240),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.content!,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                if (message.isViewed!)
                  const Text(
                    "Просмотрено",
                    style: TextStyle(
                      color: Color.fromARGB(193, 255, 255, 255),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text(
              DateFormat('dd MMM HH:mm', "ru").format(
                DateTime.tryParse(message.timestamp!.toDate().toString())!,
              ),
              style: const TextStyle(
                fontSize: 11,
                color: Color.fromARGB(226, 255, 255, 255),
                letterSpacing: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onMessageViewed(context, MessageEntity messageEntity) {
    chatScrollController.animateTo(
      chatScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    BlocProvider.of<ChatBloc>(context).add(SetMessagesIsViewed(messageEntity));
  }
}
