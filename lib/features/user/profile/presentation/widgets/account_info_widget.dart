import 'package:flutter/material.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/change_user_info_button.dart';

class AccountInfoWidget extends StatelessWidget {
  final UserEntity user;
  const AccountInfoWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 35, right: 15),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Аккаунт",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Divider(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ChangeUserInfoButton(
            onPressed: () {},
            title: user.name!,
            description: "Нажмите, чтобы изменить имя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {},
            title: user.id!,
            description: "Идентификатор пользователя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {}, title: user.about!, description: "О себе"),
      ],
    );
  }
}
