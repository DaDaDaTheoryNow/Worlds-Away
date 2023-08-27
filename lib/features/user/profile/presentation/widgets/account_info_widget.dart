import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_bloc.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_event.dart';
import 'package:worlds_away/features/user/profile/presentation/pages/change/change_page_template.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/change_info_button.dart';
import 'package:worlds_away/injection_container.dart';

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
              _goToChangePage(
                context,
                title: "Изменениe имени",
                hintText: "Придумайте новое имя...",
                onPressed: (value, bloc) =>
                    _onChangeNamePressed(value, bloc, context),
                maxCharacterCount: 15,
                isIdChange: false,
              );
            },
            title: user.name!,
            description: "Нажмите, чтобы изменить имя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {
              _goToChangePage(
                context,
                title: "Изменениe идентификатора",
                hintText: "Изменить идентификатор...",
                onPressed: (value, bloc) =>
                    _onChangeIdPressed(value, bloc, context),
                maxCharacterCount: 15,
                isIdChange: true,
              );
            },
            title: user.id!,
            description: "Идентификатор пользователя"),
        const SizedBox(
          height: 0.3,
        ),
        ChangeUserInfoButton(
            onPressed: () {
              _goToChangePage(
                context,
                title: "Изменениe информации о себе",
                hintText: "Напишите о себе...",
                onPressed: (value, bloc) =>
                    _onChangeAboutPressed(value, bloc, context),
                maxCharacterCount: 20,
                isIdChange: false,
              );
            },
            title: user.about!,
            description: "О себе"),
      ],
    );
  }

  _onChangeNamePressed(String name, ChangeBloc bloc, BuildContext context) {
    final trimmedName = name.trim();
    if (trimmedName.isNotEmpty) {
      bloc.add(ChangeName(trimmedName));
    }
  }

  _onChangeAboutPressed(String about, ChangeBloc bloc, BuildContext context) {
    final trimmedAbout = about.trim();
    if (trimmedAbout.isNotEmpty) {
      bloc.add(ChangeAbout(trimmedAbout));
    }
  }

  _onChangeIdPressed(String id, ChangeBloc bloc, BuildContext context) {
    String trimmedId = id.trim();
    if (trimmedId[0] != "@") {
      trimmedId = "@$trimmedId";
    }
    if (trimmedId.isNotEmpty) {
      bloc.add(ChangeId(trimmedId));
    }
  }

  _goToChangePage(BuildContext context,
      {required String title,
      required String hintText,
      required void Function(String, ChangeBloc) onPressed,
      required int maxCharacterCount,
      required bool isIdChange}) {
    final route = MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => ChangeBloc(sl(), sl(), sl(), sl()),
        child: ChangePageTemplate(
          title: title,
          hintText: hintText,
          onPressed: onPressed,
          maxCharacterCount: maxCharacterCount,
          isIdChange: isIdChange,
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 330),
        () => Navigator.pushAndRemoveUntil(context, route, (route) => true));
  }
}
