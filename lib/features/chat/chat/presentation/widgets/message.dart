import 'package:flutter/material.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/message.dart';

class MessageWidget extends StatelessWidget {
  final MessageEntity message;
  const MessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMy! ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor = message.isMy! ? Colors.blue : Colors.grey;

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
              message.content!,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              'From: ${message.fromUser!.name}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              'Time: ${message.timestamp.toString()}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
