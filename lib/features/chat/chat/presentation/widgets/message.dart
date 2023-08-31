import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: widget.message.content!,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                text: DateFormat('HH:mm').format(DateTime.tryParse(
                    widget.message.timestamp!.toDate().toString())!),
                style: const TextStyle(
                    fontSize: 12, color: Colors.white, letterSpacing: 2),
              ),
            ])),
            if (widget.message.isViewed!)
              const Text(
                "Просмотрено",
                style: TextStyle(
                  color: Color.fromARGB(193, 255, 255, 255),
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
