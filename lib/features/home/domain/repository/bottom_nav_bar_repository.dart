import 'package:flutter/material.dart';

abstract class BottomNavigationBarRepository {
  PageController get pageController;
  void onTap(int index);
}
