import 'package:flutter/material.dart';
import 'package:worlds_away/features/chat/chat/presentation/pages/chat_page.dart';
import 'package:worlds_away/features/chat/chats/presention/pages/chats_page.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:worlds_away/features/home/presentation/pages/setup/user_setup_page.dart';
import 'package:worlds_away/features/home/presentation/pages/home/home_page.dart';
import 'package:worlds_away/features/profile/presentation/pages/current_user_profile_page.dart';
import 'package:worlds_away/features/search/presentation/pages/users_search_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const AuthPage());

      case '/Home':
        return _materialRoute(const HomePage());

      case '/UserSetup':
        return _materialRoute(const UserSetupPage());

      case '/CurrentUserProfile':
        return _materialRoute(const CurrentUserProfilePage());

      case '/UsersSearch':
        return _materialRoute(const UsersSearchPage());

      case '/UsersChats':
        return _materialRoute(const ChatsPage());

      case '/Chat':
        return _materialRoute(ChatPage(
          user: settings.arguments as UserEntity,
        ));

      default:
        return _materialRoute(const AuthPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
