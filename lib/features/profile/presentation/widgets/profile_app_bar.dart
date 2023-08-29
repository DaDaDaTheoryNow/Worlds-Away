import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/user_app_bar_avatar.dart';

class ProfileAppBar extends StatelessWidget {
  final UserEntity user;
  final Function() onPressed;
  const ProfileAppBar({super.key, required this.user, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
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
