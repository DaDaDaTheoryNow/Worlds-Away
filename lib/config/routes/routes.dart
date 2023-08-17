import 'package:flutter/material.dart';
import 'package:worlds_away/features/user/auth/presentation/pages/auth/auth_page.dart';
import 'package:worlds_away/features/home/presentation/pages/setup/user_setup_page.dart';
import 'package:worlds_away/features/home/presentation/pages/home/home_page.dart';
import 'package:worlds_away/features/user/profile/presentation/pages/my_profile_page.dart';
import 'package:worlds_away/features/user/search/presentation/pages/users_search_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const AuthPage());

      case '/Home':
        return _materialRoute(const HomePage());

      case '/UserSetup':
        return _materialRoute(const UserSetupPage());

      case '/Profile':
        return _materialRoute(
            MyProfilePage(userUniqueId: settings.arguments as String));

      case '/UsersSearch':
        return _materialRoute(const UsersSearchPage());

      default:
        return _materialRoute(const AuthPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
