import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/message.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';

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
          if (state.messages!.isEmpty) {
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

          return ListView.builder(
            itemCount: state.messages!.length,
            itemBuilder: (context, index) {
              final message = state.messages![index];

              return MessageWidget(message);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
