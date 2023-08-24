import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/domain/entities/send_message.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

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
                    _onSendMessagePressed(message, user.uniqueUid!, context);

                    messageController.clear();
                  }
                }),
          ],
        ),
      ),
    );
  }

  _onSendMessagePressed(String message, String receiverUniqueUid, context) {
    BlocProvider.of<ChatBloc>(context).add(SendMessage(SendMessageEntity(
        content: message,
        receiverUniqueUid: receiverUniqueUid,
        timestamp: Timestamp.now())));
  }
}
