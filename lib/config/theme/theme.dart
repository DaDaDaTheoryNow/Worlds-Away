import 'package:flutter/material.dart';
import 'package:worlds_away/core/constants/constants.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundColor,
    actionIconTheme: _buildActionIconThemeData(),
    elevatedButtonTheme: _elevatedButtonThemeData(),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
    appBarTheme: _appBarTheme(),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(42),
        ),
      ),
    );

BottomNavigationBarThemeData _bottomNavigationBarThemeData() =>
    const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: containerColor,
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

AppBarTheme _appBarTheme() => const AppBarTheme(
    color: containerColor,
    toolbarHeight: appBarHeight,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ));

ActionIconThemeData _buildActionIconThemeData() => ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
      ),
    );
