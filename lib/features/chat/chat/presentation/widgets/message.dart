import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';

class MessageWidget extends StatelessWidget {
  final MessageEntity message;
  const MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMy! ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = message.isMy! ? Colors.blue : Colors.grey;

    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction == 1.0) {
          _onMessageViewed(context, message);
        }
      },
      child: Align(
        alignment: alignment,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content!,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'От: ${message.fromUser!.name}',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              Text(
                'Время: ${timeago.format(DateTime.tryParse(message.timestamp!.toDate().toString())!, locale: "ru")}',
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              Text(
                message.isViewed.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onMessageViewed(context, MessageEntity messageEntity) {
    BlocProvider.of<ChatBloc>(context).add(SetMessageIsViewed(messageEntity));
  }
}
