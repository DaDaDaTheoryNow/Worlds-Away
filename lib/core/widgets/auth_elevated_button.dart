import 'package:flutter/material.dart';

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
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 14),
          )),
    );
  }
}
