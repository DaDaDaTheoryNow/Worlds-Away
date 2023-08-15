import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAppBarAvatar extends StatelessWidget {
  final String photoUrl;
  const UserAppBarAvatar(this.photoUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: photoUrl,
        width: 45,
        height: 45,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
