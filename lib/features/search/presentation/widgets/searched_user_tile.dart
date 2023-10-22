import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

class SearchedUserTile extends StatelessWidget {
  final UserEntity user;
  const SearchedUserTile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      height: 75,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(28, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onChatPressed(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.photoUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        user.about!,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 177, 177, 177),
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
      ),
    );
  }

  _onChatPressed(context) {
    Future.delayed(
        const Duration(milliseconds: 320),
        () => Navigator.pushNamedAndRemoveUntil(
            context, "/Chat", (route) => true,
            arguments: user));
  }
}
