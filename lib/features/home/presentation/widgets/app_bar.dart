import 'package:flutter/material.dart';
import 'package:worlds_away/features/home/presentation/widgets/user_app_bar_avatar.dart';

class AppBarWidget extends StatelessWidget {
  final String photoUrl;
  const AppBarWidget({required this.photoUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Worlds Away",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: UserAppBarAvatar(photoUrl),
          )
        ]);
  }
}
