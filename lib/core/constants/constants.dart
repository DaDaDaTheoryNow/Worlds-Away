import 'package:flutter/cupertino.dart';

const List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble), label: "Чат"),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: "Искать")
];

const Color greyColor = Color.fromARGB(255, 29, 29, 29);

const double appBarHeight = 75;

const String firestoreCollectionUsers = "users";

const String prefsHasUserDescriptionKey = "hasUserDescription";
