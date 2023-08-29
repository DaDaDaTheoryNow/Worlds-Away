import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

import 'package:worlds_away/features/shared/common/presentation/widgets/auth_elevated_button.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/shared/user/online/domain/usecases/update_user_online_status_usecase.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_event.dart';
import 'package:worlds_away/features/shared/user/online/presentation/observers/user_online_observer.dart';
import 'package:worlds_away/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:worlds_away/features/auth/presentation/blocs/auth/auth_event.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_state.dart';
import 'package:worlds_away/features/profile/presentation/widgets/account_info_widget.dart';
import 'package:worlds_away/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:worlds_away/features/search/presentation/blocs/search_bloc.dart';
import 'package:worlds_away/features/search/presentation/blocs/search_event.dart';
import 'package:worlds_away/injection_container.dart';

class CurrentUserProfilePage extends StatelessWidget {
  const CurrentUserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CupertinoLoading();
        }

        if (state is ProfileDone) {
          return Scaffold(
            appBar: _buildAppBar(state.user!),
            body: Column(
              children: [
                AccountInfoWidget(user: state.user!),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildSignOutWithGoogleButton(context),
                ),
              ],
            ),
          );
        }

        if (state is ProfileError) {
          return Scaffold(
              body: Center(child: MyErrorWidget(error: state.error!)));
        }

        return const SizedBox();
      },
    );
  }

  _buildAppBar(UserEntity user) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: ProfileAppBar(
        user: user,
        onPressed: () {},
      ),
    );
  }

  _buildSignOutWithGoogleButton(context) {
    return AuthElevatedButton(
        title: "Выйти", function: () => _onSignOutPressed(context));
  }

  _onSignOutPressed(context) {
    UserOnlineObserver(sl<UpdateUserOnlineStatusUseCase>(), sl<FirebaseAuth>())
        .updateUserOnline(false);

    BlocProvider.of<BottomNavigationBarBloc>(context).add(const OnTap(0));
    BlocProvider.of<AuthBloc>(context).add(const SignOut());
    BlocProvider.of<SearchBloc>(context).add(ResetSearchState());
  }
}
