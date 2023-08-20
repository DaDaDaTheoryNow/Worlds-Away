import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_event.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat_app_bar.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat_text_field.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class ChatPage extends StatefulWidget {
  final UserEntity user;
  const ChatPage({required this.user, super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    BlocProvider.of<ChatBloc>(context)
        .add(GetMessagesStream(widget.user.uniqueUid!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _buildBody(),
          ),
          _buildTextField(),
        ],
      ),
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: ChatAppBar(widget.user),
    );
  }

  _buildBody() {
    return const ChatWidget();
  }

  _buildTextField() {
    return ChatTextField(widget.user);
  }
}
