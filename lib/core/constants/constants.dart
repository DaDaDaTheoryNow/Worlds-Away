import 'package:flutter/cupertino.dart';

const List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble), label: "Чат"),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: "Искать"),
  BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled), label: "Профиль")
];

const Color greyColor = Color.fromARGB(255, 29, 29, 29);
const Color backgroundColor = Color.fromRGBO(16, 18, 26, 1);
const Color containerColor = Color.fromRGBO(23, 28, 39, 1);

const double appBarHeight = 75;

const String firestoreCollectionUsers = "users";
const String firestoreCollectionChats = "chats";

const String prefsHasUserDescriptionKey = "hasUserDescription";

const int maxNameLength = 15;
const int maxIdLength = 15;
const int maxAboutLength = 20;

const String serverSecretKey =
    "AAAAIOhfKPI:APA91bFD-8sy1-Ce4f0cS4BODjxUlmO-r2Nqa0LZ3z2DEll0TCz4pz_ey-dXfZQXa6lbDe6oX57Ens2Dpt7rb3nThgZ6gJvzrVmTdkRK1ow6qUhOzu-MR9AIHA5uaxzJKWcR56T7LfzD";
