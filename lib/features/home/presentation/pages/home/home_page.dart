import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worlds_away/features/chat/chats/presention/pages/chats_page.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_state.dart';

import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_state.dart';

import 'package:worlds_away/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/user/profile/presentation/pages/current_user_profile_page.dart';
import 'package:worlds_away/features/user/search/presentation/pages/users_search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserSetupBloc>(context).add(const GetUserSetup());

    return BlocBuilder<UserSetupBloc, UserSetupState>(
      builder: (context, state) {
        if (state is UserSetupLoading) {
          return const CupertinoLoading();
        }

        if (state is UserSetupError) {
          return Scaffold(body: MyErrorWidget(error: state.error!));
        }

        if (state.status == UserSetupStatus.empty) {
          _onUserSetupEmpty(context);
          return const CupertinoLoading();
        }

        if (state.status == UserSetupStatus.filled) {
          return Scaffold(
              body: _buildPageView(),
              bottomNavigationBar: _buildBottomNavigationBarWidget());
        }

        return const SizedBox();
      },
    );
  }

  _buildPageView() {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: state.pageController,
          children: const [
            ChatsPage(),
            UsersSearchPage(),
            CurrentUserProfilePage(),
          ],
        );
      },
    );
  }

  _buildBottomNavigationBarWidget() {
    return const BottomNavigationBarWidget();
  }

  _onUserSetupEmpty(context) {
    Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context, "/UserSetup", (route) => true));
  }
}
