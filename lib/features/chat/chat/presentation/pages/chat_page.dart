import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat_app_bar.dart';
import 'package:worlds_away/features/chat/chat/presentation/widgets/chat_text_field.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/injection_container.dart';

class ChatPage extends StatelessWidget {
  final UserEntity user;
  const ChatPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(sl(), sl(), sl(), user.uniqueUid!),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: [
            Expanded(
              child: _buildBody(),
            ),
            _buildTextField(),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: ChatAppBar(),
    );
  }

  _buildBody() {
    return const ChatWidget();
  }

  _buildTextField() {
    return ChatTextField(user);
  }
}
