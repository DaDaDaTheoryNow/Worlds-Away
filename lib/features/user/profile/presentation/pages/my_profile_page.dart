import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/common/presentation/widgets/auth_elevated_button.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_event.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/auth/auth_event.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_bloc.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_event.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_state.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/account_info_widget.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/sliver_profile_app_bar.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_bloc.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_event.dart';

class MyProfilePage extends StatefulWidget {
  final String? userUniqueId;
  const MyProfilePage({super.key, this.userUniqueId});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context)
        .add(GetUserProfile(widget.userUniqueId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const CupertinoLoading();
        }

        if (state is ProfileDone) {
          return StreamBuilder(
            stream: state.user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverProfileAppBar(
                      user: snapshot.data!,
                      onPressed: () {},
                    ),
                    SliverToBoxAdapter(
                      child: AccountInfoWidget(user: snapshot.data!),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: true,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: _buildSignOutWithGoogleButton(context),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const CupertinoLoading();
              }
            },
          );
        }

        if (state is ProfileError) {
          return MyErrorWidget(error: state.error!);
        }

        return const SizedBox();
      },
    );
  }

  _buildSignOutWithGoogleButton(context) {
    return AuthElevatedButton(
        title: "Выйти", function: () => _onSignOutPressed(context));
  }

  _onSignOutPressed(context) {
    BlocProvider.of<SearchBloc>(context).add(ResetSearchState());
    BlocProvider.of<BottomNavigationBarBloc>(context).add(const OnTap(0));
    Future.microtask(() => Navigator.pop(context));
    BlocProvider.of<AuthBloc>(context).add(const SignOut());
  }
}
