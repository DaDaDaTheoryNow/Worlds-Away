import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/user_app_bar_avatar.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_state.dart';

import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/user_setup/user_setup_state.dart';

import 'package:worlds_away/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/user/search/presentation/pages/users_search_page.dart';
import 'package:worlds_away/injection_container.dart';

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
              appBar: _buildAppBarWidget(state.photoUrl ?? "", context),
              body: _buildPageView(),
              bottomNavigationBar: _buildBottomNavigationBarWidget());
        }

        return const SizedBox();
      },
    );
  }

  PreferredSize _buildAppBarWidget(String photoUrl, BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Worlds Away",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: UserAppBarAvatar(
                  photoUrl: photoUrl,
                  radius: 45,
                  iconData: Icons.edit,
                  onPressed: () => _onUserAvatarPressed(context),
                  width: 70,
                ),
              )
            ]));
  }

  _buildPageView() {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: state.pageController,
          children: const [
            Center(child: Text("General")),
            UsersSearchPage(),
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

  _onUserAvatarPressed(context) {
    Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context,
        "/Profile",
        arguments: sl<FirebaseAuth>().currentUser!.uid,
        (route) => true));
  }
}
