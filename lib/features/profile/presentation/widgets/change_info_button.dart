import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

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
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: containerColor,
            alignment: Alignment.topLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          )),
    );
  }
}
