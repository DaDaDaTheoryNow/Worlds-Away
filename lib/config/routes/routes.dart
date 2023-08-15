import 'package:flutter/material.dart';
import 'package:worlds_away/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:worlds_away/features/home/presentation/pages/setup/user_setup_page.dart';
import 'package:worlds_away/features/home/presentation/pages/home/home_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const AuthPage());

      case '/Home':
        return _materialRoute(const HomePage());

      case '/UserSetup':
        return _materialRoute(const UserSetupPage());

      default:
        return _materialRoute(const AuthPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
