import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

class ChatTextField extends StatelessWidget {
  final UserEntity user;
  const ChatTextField(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController messageController = TextEditingController();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: messageController,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    hintText: 'Напишите ваше сообщение...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Невозможно отправить пустое сообщение";
                  }

                  return null;
                },
              ),
            ),
            IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final message = messageController.text.trim();

                    // Dispatch event to send the message
                    _onSendMessagePressed(message, user, context);

                    messageController.clear();
                  }
                }),
          ],
        ),
      ),
    );
  }

  _onSendMessagePressed(String message, UserEntity user, context) {
    if (chatScrollController.onAttach != null) {
      chatScrollController.animateTo(
        chatScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    BlocProvider.of<ChatBloc>(context).add(SendMessage(SendMessageEntity(
      content: message,
      toUser: user,
      timestamp: Timestamp.now(),
    )));
  }
}
