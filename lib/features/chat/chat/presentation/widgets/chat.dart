import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/message.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/my_error_widget.dart';

final ScrollController chatScrollController = ScrollController();

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatError) {
          return MyErrorWidget(error: state.error!);
        }

        if (state is ChatLoading) {
          return const CupertinoLoading();
        }

        if (state is ChatDone) {
          final messages = state.chatInfo!.messages!.reversed.toList();
          if (messages.isEmpty) {
            return const Center(
              child: Text(
                "Начните переписку первым",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  controller: chatScrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageWidget(message);
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 6,
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
