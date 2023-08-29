import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

class AuthElevatedButton extends StatelessWidget {
  final String title;
  final Function() function;
  const AuthElevatedButton(
      {required this.title, required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
              backgroundColor: containerColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
          )),
    );
  }
}
