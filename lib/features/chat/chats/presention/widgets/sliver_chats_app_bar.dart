import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

class SliverChatsAppBar extends StatelessWidget {
  const SliverChatsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      floating: true,
      toolbarHeight: appBarHeight,
      backgroundColor: containerColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 23,
      ),
      title: Text(
        "Сообщения",
      ),
    );
  }
}
