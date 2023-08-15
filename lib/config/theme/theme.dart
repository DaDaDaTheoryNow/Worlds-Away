import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: _elevatedButtonThemeData(),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
    appBarTheme: _appBarTheme(),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(42),
      ),
    ),
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
  return const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: greyColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(
      size: 24,
    ),
    unselectedIconTheme: IconThemeData(
      size: 20,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    type: BottomNavigationBarType.fixed,
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
      color: greyColor,
      toolbarHeight: appBarHeight,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ));
}
