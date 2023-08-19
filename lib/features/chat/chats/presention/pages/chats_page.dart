import 'package:flutter/material.dart';
import 'package:worlds_away/features/chat/chats/presention/widgets/chats.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return const ChatsWidget();
  }
}
