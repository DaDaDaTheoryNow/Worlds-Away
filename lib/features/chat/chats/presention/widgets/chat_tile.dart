import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:worlds_away/features/chat/chats/domain/entities/chat_entity.dart';

class ChatTile extends StatelessWidget {
  final ChatEntity chat;
  const ChatTile(this.chat, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      height: 75,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(28, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onChatPressed(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: chat.user.photoUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: (chat.user.isOnline!)
                              ? Colors.green
                              : Colors.grey,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                chat.user.name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            if (chat.messagesToNotViewed > 0)
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(42)),
                                child: Center(
                                  child: Text(
                                    chat.messagesToNotViewed.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          chat.lastMessage,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 177, 177, 177),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onChatPressed(context) {
    Future.delayed(
        const Duration(milliseconds: 320),
        () => Navigator.pushNamedAndRemoveUntil(
            context, "/Chat", (route) => true,
            arguments: chat.user));
  }
}
