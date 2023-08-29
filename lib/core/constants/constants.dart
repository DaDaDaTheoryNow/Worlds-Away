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

const String bearerFcmToken =
    "ya29.c.b0Aaekm1LxfQH26Aj9zQUfugeLur9PLMa5mVc3viCXykMLOiXGnFYpOj_pWKN7_iisUsVsnJE3YrWGtLlC_hmTmsUagu_F3fow28yx04EL7clPBAb3OHsFPK_JnqM7dOFDniEp5c_E4J1Pd4xmi1WshMM0h18sv3JJS2eWx4k2LPi-60ssW8w9efbxxWbnWQ_RwPfZzo5fv4ZK00xYkMev520yqNHf3hGOW6pOJs5Eq1fBaS331f4hWkL7dlzGqde-ruSHNaiVU4teewEPG1EECmRiJQP5WCo23jxTo5ISpBecdIYNjyBQpGLAnnvEeks6vsb0TdfxVgT339Pvw66eha-p7d1d8woFbX9wraxVbSwYkkjYnuO_uiJmgZ43cohz1aSM1yVc6hJ0bV2qSe3zvyQI6Zu47rVpkzkbnogvX9p2v8Bn0hfYB6M-9w-oSWgrx259sYO385OxJttlq3Wqpohc-WwFO1IkFfJpqjmjQdOdBM6XeIcebie7SRjby2Ix-JZpY2VVs1cc0u0Urqksgan7Id7Iq88S1xFpiIF7r2ojSwVsMt0XBp4w07g9RnzweZ9t9YSbo81uZRjI3a1q8ok8n5xScOy9xtaifn2m0ZB6gbyFtvRIYqbwk7xb3mfgZraX9sh530bB9ntriyYVpZyVksre3WfipRrRImOYeSBgihl8ciXY98bqobdUWw6zpw3qQyalk5mcvSU96in0W8sBwQq_wVWwnh6yQn8XgbjxMj_mWi51XufYnOVjq3qvph0nFz42Ip2g7lpFqXJgaZtxoa8k2WgssuBXwFd5oyjprhWWjs9tZF1lUahdQmQf2xaMh-i4fUcWMf1WOeXWvROk-stUFtlMYUvvg2z7YeSu9Focl0eai5BqxWyyZFcnUnuYbUJiUl0Bx9scdtRQerOItr9OouvOxiFXV3Y8b6B-ap5JgaYtVuXogbX54enfB5ovv4gocRVYXZiwx2FQSMr27UosxaWpJ1l8ugO5650IsnFJ0Vg3gB_";
