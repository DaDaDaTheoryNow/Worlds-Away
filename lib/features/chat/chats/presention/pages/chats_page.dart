import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chats/presention/widgets/sliver_chats_app_bar.dart';
import 'package:worlds_away/features/chat/chats/presention/widgets/sliver_chats.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(42),
        ),
      ),
      child: const CustomScrollView(
        slivers: [
          SliverChatsAppBar(),
          SliverChats(),
        ],
      ),
    );
  }
}
