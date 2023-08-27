import 'package:flutter/material.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/user/profile/presentation/pages/change/change_page_template.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/change_info_button.dart';

class AccountInfoWidget extends StatelessWidget {
  final UserEntity user;
  const AccountInfoWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        ChangeUserInfoButton(
            onPressed: () {
              _changeName(context,
                  title: "Изменениe имени",
                  hintText: "Изменить имя...",
                  onPressed: () {});
            },
            title: user.name!,
            description: "Нажмите, чтобы изменить имя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {
              _changeName(context,
                  title: "Изменениe идентификатора",
                  hintText: "Изменить идентификатор...",
                  onPressed: () {});
            },
            title: user.id!,
            description: "Идентификатор пользователя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {
              _changeName(context,
                  title: "Изменениe информации о себе",
                  hintText: "Изменить о себе...",
                  onPressed: () {});
            },
            title: user.about!,
            description: "О себе"),
      ],
    );
  }

  _changeName(BuildContext context,
      {required String title,
      required String hintText,
      required Function() onPressed}) {
    final route = MaterialPageRoute(
      builder: (context) => ChangePageTemplate(
          title: title, hintText: hintText, onPressed: onPressed),
    );

    Future.delayed(const Duration(milliseconds: 330),
        () => Navigator.pushAndRemoveUntil(context, route, (route) => true));
  }
}
