import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

class SaveButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const SaveButton({required this.onPressed, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: containerColor),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
