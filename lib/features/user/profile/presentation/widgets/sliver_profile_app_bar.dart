import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/common/presentation/widgets/user_app_bar_avatar.dart';

class SliverProfileAppBar extends StatelessWidget {
  final UserEntity user;
  final Function() onPressed;
  const SliverProfileAppBar(
      {super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: appBarHeight,
      centerTitle: true,
      title: UserAppBarAvatar(
        photoUrl: user.photoUrl!,
        radius: 45,
        iconData: Icons.edit_document,
        onPressed: onPressed,
        width: 70,
      ),
    );
  }
}
