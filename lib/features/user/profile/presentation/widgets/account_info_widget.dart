import 'package:flutter/material.dart';
import 'package:worlds_away/features/common/domain/entity/user.dart';

class AccountInfoWidget extends StatelessWidget {
  final UserEntity user;
  const AccountInfoWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Аккаунт",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              Text(user.name!),
              Text(user.id!),
              Text(user.about!)
            ],
          ),
        ));
  }
}
