import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';

class MessageWidget extends StatefulWidget {
  final MessageEntity message;
  const MessageWidget(this.message, {super.key});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    if (!widget.message.isViewed!) {
      _onMessageViewed(context, widget.message);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alignment =
        widget.message.isMy! ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = widget.message.isMy! ? Colors.blue : Colors.grey;

    return Align(
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
              widget.message.content!,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'От: ${widget.message.fromUser!.name}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Время: ${timeago.format(DateTime.tryParse(widget.message.timestamp!.toDate().toString())!, locale: "ru")}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            if (!widget.message.isViewed!)
              const Icon(
                Icons.check,
                size: 13,
                color: Colors.black,
              )
            else
              RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.black,
                    )),
                    WidgetSpan(
                        child: Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.black,
                    ))
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  _onMessageViewed(context, MessageEntity messageEntity) {
    BlocProvider.of<ChatBloc>(context).add(SetMessagesIsViewed(messageEntity));
  }
}
