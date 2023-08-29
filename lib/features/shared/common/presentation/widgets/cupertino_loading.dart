import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoLoading extends StatelessWidget {
  final bool? isCenter;
  const CupertinoLoading({super.key, this.isCenter});

  @override
  Widget build(BuildContext context) {
    return (isCenter != null && !isCenter!)
        ? const CupertinoActivityIndicator(
            color: Colors.white,
          )
        : const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          );
  }
}
