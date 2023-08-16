import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/local/shared_preferences/local_auth_impl.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/local/shared_preferences/local_auth_repository.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/remote/firebase_auth/remote_auth_impl.dart';
import 'package:worlds_away/features/user/auth/data/data_sources/remote/firebase_auth/remote_auth_repository.dart';
import 'package:worlds_away/features/user/auth/data/repositories/auth_repository.dart';
import 'package:worlds_away/features/home/data/data_sources/local/local_user_setup_impl.dart';
import 'package:worlds_away/features/home/data/data_sources/local/local_user_setup_repository.dart';
import 'package:worlds_away/features/home/data/data_sources/remote/remote_user_setup_impl.dart';
import 'package:worlds_away/features/home/data/data_sources/remote/remote_user_setup_repository.dart';
import 'package:worlds_away/features/home/data/repository/bottom_nav_bar_repository.dart';
import 'package:worlds_away/features/user/auth/data/repositories/user_auth_repository.dart';
import 'package:worlds_away/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:worlds_away/features/home/domain/repository/bottom_nav_bar_repository.dart';
import 'package:worlds_away/features/user/auth/domain/repositories/user_auth_repository.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';
import 'package:worlds_away/features/home/domain/usecases/bottom_nav_bar_on_tap.dart';
import 'package:worlds_away/features/user/auth/domain/usecases/check_user_auth_status.dart';
import 'package:worlds_away/features/user/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worlds_away/features/user/auth/domain/usecases/sign_out_and_clear_user_setup_bool.dart';
import 'package:worlds_away/features/home/domain/usecases/check_id_available.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_information.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_local_information.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_setup_state.dart';
import 'package:worlds_away/features/home/domain/usecases/send_user_setup_information.dart';
import 'package:worlds_away/features/home/domain/usecases/set_user_setup_bool.dart';

import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/setup_page/setup_page_bloc.dart';
import 'package:worlds_away/features/user/profile/data/data_sources/remote/remote_profile_impl.dart';
import 'package:worlds_away/features/user/profile/data/data_sources/remote/remote_profile_repository.dart';
import 'package:worlds_away/features/user/profile/data/repository/profile_repository.dart';
import 'package:worlds_away/features/user/profile/domain/repository/profile_repository.dart';
import 'package:worlds_away/features/user/profile/domain/usecases/get_user_profile.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_bloc.dart';

import 'features/user/auth/presentation/blocs/auth/auth_bloc.dart';
import 'features/user/auth/presentation/blocs/user_auth_status/user_auth_bloc.dart';
import 'features/home/data/repository/user_setup_repository.dart';
import 'features/home/presentation/blocs/setup/user_setup/user_setup_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final PageController pageController = PageController();
  sl.registerSingleton<PageController>(pageController);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // auth with firebase
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  // repositories
  sl.registerSingleton<RemoteAuthRepository>(
      FirebaseAuthImpl(sl(), sl(), sl()));

  sl.registerSingleton<LocalAuthRepository>(LocalAuthImpl(prefs));

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl(), sl()));

  sl.registerSingleton<UserAuthRepository>(UserAuthRepositoryImpl(sl()));

  sl.registerSingleton<BottomNavigationBarRepository>(
      BottomNavigatonBarRepositoryImpl());

  sl.registerSingleton<LocalUserSetupRepository>(
      LocalUserSetupImpl(prefs, sl()));
  sl.registerSingleton<RemoteUserSetupRepository>(
      RemoteUserSetupImpl(sl(), sl()));

  sl.registerSingleton<UserSetupRepository>(
      UserSetupRepositoryImpl(sl(), sl()));

  sl.registerSingleton<RemoteProfileRepository>(
      RemoteProfileRepositoryImpl(prefs, sl(), sl()));

  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase(sl()));

  sl.registerSingleton<SignInOutAndClearUserSetupBoolUseCase>(
      SignInOutAndClearUserSetupBoolUseCase(sl()));

  sl.registerSingleton<CheckUserAuthStatusUseCase>(
      CheckUserAuthStatusUseCase(sl()));

  sl.registerSingleton<BottomNavBarOnTapUseCase>(
      BottomNavBarOnTapUseCase(sl()));

  sl.registerSingleton<GetUserSetupStateUseCase>(
      GetUserSetupStateUseCase(sl<UserSetupRepository>()));

  sl.registerSingleton<SetUserSetupBoolUseCase>(SetUserSetupBoolUseCase(sl()));

  sl.registerSingleton<SendUserSetupInformationUseCase>(
      SendUserSetupInformationUseCase(sl()));

  sl.registerSingleton<GetUserInformationUseCase>(
      GetUserInformationUseCase(sl()));

  sl.registerSingleton<CheckIdAvailableUseCase>(CheckIdAvailableUseCase(sl()));

  sl.registerSingleton<GetUserLocalInformationUseCase>(
      GetUserLocalInformationUseCase(sl()));

  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase(sl()));

  // factory
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));

  sl.registerFactory<UserAuthBloc>(() => UserAuthBloc(sl()));

  sl.registerFactory<BottomNavigationBarBloc>(
      () => BottomNavigationBarBloc(sl(), sl()));

  sl.registerFactory<UserSetupBloc>(() => UserSetupBloc(sl(), sl(), sl()));

  sl.registerFactory<SetupPageBloc>(
      () => SetupPageBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
}
