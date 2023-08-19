import 'package:flutter/material.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

class ChatAppBar extends StatelessWidget {
  final UserEntity user;
  const ChatAppBar(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(user.name!),
    );
  }
}
