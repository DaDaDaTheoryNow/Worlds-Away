import 'package:flutter/material.dart';
import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';
import 'package:worlds_away/features/common/presentation/widgets/user_app_bar_avatar.dart';

class ChatTile extends StatelessWidget {
  final ChatEntity chat;
  const ChatTile(this.chat, {super.key});

  @override
  Widget build(BuildContext context) {
    final user = chat.user;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      radius: 55,
      onTap: () => _onChatPressed(context),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        height: 75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAppBarAvatar(
                photoUrl: user.photoUrl!,
                radius: 43,
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.id!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      user.about!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onChatPressed(context) {
    Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context, "/Chat", (route) => true,
        arguments: chat.user));
  }
}
