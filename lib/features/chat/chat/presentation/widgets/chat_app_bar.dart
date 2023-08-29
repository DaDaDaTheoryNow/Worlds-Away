import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_state.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/cupertino_loading.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatDone) {
          final user = state.chatInfo!.receiverUser;

          if (user != null) {
            return AppBar(
              title: Text(user.name!),
              actions: [
                (user.isOnline!)
                    ? const Text(
                        "Онлайн",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const Text(
                        "Не в сети",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                const SizedBox(
                  width: 15,
                )
              ],
            );
          } else {
            return AppBar(
              title: const CupertinoLoading(
                isCenter: false,
              ),
            );
          }
        } else {
          return AppBar(
            centerTitle: false,
            title: const CupertinoLoading(
              isCenter: false,
            ),
          );
        }
      },
    );
  }
}
