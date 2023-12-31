import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_bloc.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';

import 'package:worlds_away/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/setup_page/setup_page_bloc.dart';
import 'package:worlds_away/features/home/presentation/pages/home/home_page.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_event.dart';
import 'package:worlds_away/features/search/presentation/blocs/search_bloc.dart';

import 'config/routes/routes.dart';
import 'config/theme/theme.dart';

import 'features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'features/auth/presentation/blocs/user_auth_status/user_auth_bloc.dart';
import 'features/auth/presentation/blocs/user_auth_status/user_auth_event.dart';
import 'features/auth/presentation/blocs/user_auth_status/user_auth_state.dart';

import 'features/home/presentation/blocs/setup/user_setup/user_setup_bloc.dart';
import 'init_background_service.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await initializeDependencies();

  await initializeService();

  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  initializeDateFormatting('ru', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  sl<UserAuthBloc>()..add(const CheckUserAuthStatus())),
          BlocProvider(create: (_) => sl<AuthBloc>()),
          BlocProvider(create: (_) => sl<BottomNavigationBarBloc>()),
          BlocProvider(create: (_) => sl<UserSetupBloc>()),
          BlocProvider(create: (_) => sl<SetupPageBloc>()),
          BlocProvider(create: (_) => sl<ProfileBloc>()),
          BlocProvider(create: (_) => sl<SearchBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: _buildWayOpen(),
        ));
  }

  _buildWayOpen() {
    return BlocBuilder<UserAuthBloc, UserAuthState>(
      builder: (context, state) {
        if (state.status == UserAuthStatus.authenticated) {
          BlocProvider.of<ProfileBloc>(context).add(GetCurrentUserProfile());

          // providing chats
          return BlocProvider(
              create: (_) => sl<ChatsBloc>(), child: const HomePage());
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
