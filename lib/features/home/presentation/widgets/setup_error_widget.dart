import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetupErrorWidget extends StatelessWidget {
  final String error;
  const SetupErrorWidget({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const CupertinoActivityIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
