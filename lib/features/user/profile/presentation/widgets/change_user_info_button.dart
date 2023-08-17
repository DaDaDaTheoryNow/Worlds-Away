import 'package:flutter/material.dart';

class ChangeUserInfoButton extends StatelessWidget {
  final String title;
  final String description;
  final Function() onPressed;
  const ChangeUserInfoButton(
      {required this.onPressed,
      required this.title,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            alignment: Alignment.topLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          )),
    );
  }
}
