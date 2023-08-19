import 'package:flutter/material.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/common/presentation/widgets/user_app_bar_avatar.dart';

class SearchedUserTile extends StatelessWidget {
  final UserEntity user;
  const SearchedUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      radius: 65,
      onTap: () {
        debugPrint("searched user was clicked");
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        height: 75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAppBarAvatar(
                photoUrl: user.photoUrl!,
                radius: 43,
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(user.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          user.id!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      user.about!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
