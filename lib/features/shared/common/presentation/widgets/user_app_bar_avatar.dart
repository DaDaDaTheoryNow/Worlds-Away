import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:worlds_away/core/constants/constants.dart';

class UserAppBarAvatar extends StatelessWidget {
  final String photoUrl;
  final double radius;
  final double width;
  final IconData? iconData;
  final Function()? onPressed;

  const UserAppBarAvatar({
    required this.photoUrl,
    required this.radius,
    this.iconData,
    this.onPressed,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius + 15,
      width: radius + width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(42),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: photoUrl,
              width: radius,
              height: radius,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          if (onPressed != null && iconData != null)
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                iconData,
                color: Colors.white,
              ),
            )
        ],
      ),
    );
  }
}
