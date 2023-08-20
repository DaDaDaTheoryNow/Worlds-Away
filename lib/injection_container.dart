import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/get_messages_stream.dart';
import 'package:worlds_away/features/chat/chat/domain/usecases/send_message.dart';
import 'package:worlds_away/features/chat/chat/presentation/blocs/chat_bloc.dart';
import 'package:worlds_away/features/chat/chats/data/data_sources/remote/remote_chats_impl.dart';
import 'package:worlds_away/features/chat/chats/data/data_sources/remote/remote_chats_repository.dart';
import 'package:worlds_away/features/chat/chats/data/repository/chats_repository.dart';
import 'package:worlds_away/features/chat/chats/domain/repository/chats_repository.dart';
import 'package:worlds_away/features/chat/chats/domain/usecases/get_chats_stream.dart';
import 'package:worlds_away/features/chat/chats/presention/blocs/chats_bloc.dart';
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
import 'package:worlds_away/features/user/search/data/data_sources/remote/remote_search_impl.dart';
import 'package:worlds_away/features/user/search/data/data_sources/remote/remote_search_repository.dart';
import 'package:worlds_away/features/user/search/data/repository/search_repository.dart';
import 'package:worlds_away/features/user/search/domain/repository/search_repository.dart';
import 'package:worlds_away/features/user/search/domain/usecases/get_searched_users_stream.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_bloc.dart';

import 'features/chat/chat/data/data_sources/remote/remote_chat_impl.dart';
import 'features/chat/chat/data/data_sources/remote/remote_chat_repository.dart';
import 'features/chat/chat/data/repository/chat_repository.dart';
import 'features/chat/chat/domain/repository/chat_repository.dart';
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
      RemoteProfileRepositoryImpl(prefs, sl()));

  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(sl()));

  sl.registerSingleton<RemoteSearchRepository>(RemoteSearchImpl(sl(), sl()));

  sl.registerSingleton<SearchRepository>(SearchRepositoryImpl(sl()));

  sl.registerSingleton<RemoteChatsRepository>(RemoteChatsImpl(sl(), sl()));
  sl.registerSingleton<ChatsRepository>(ChatsRepositoryImpl(sl()));

  sl.registerSingleton<RemoteChatRepository>(RemoteChatImpl(sl(), sl()));
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl(sl()));

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

  sl.registerSingleton<GetSearchedUsersStreamUseCase>(
      GetSearchedUsersStreamUseCase(sl()));

  sl.registerSingleton<GetChatsStreamUseCase>(GetChatsStreamUseCase(sl()));

  sl.registerSingleton<GetMessagesStreamUseCase>(
      GetMessagesStreamUseCase(sl()));

  sl.registerSingleton<SendMessageUseCase>(SendMessageUseCase(sl()));

  // factory
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl()));

  sl.registerFactory<UserAuthBloc>(() => UserAuthBloc(sl()));

  sl.registerFactory<BottomNavigationBarBloc>(
      () => BottomNavigationBarBloc(sl(), sl()));

  sl.registerFactory<UserSetupBloc>(() => UserSetupBloc(sl(), sl(), sl()));

  sl.registerFactory<SetupPageBloc>(
      () => SetupPageBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(), sl()));

  sl.registerFactory<SearchBloc>(() => SearchBloc(sl()));

  sl.registerFactory<ChatsBloc>(() => ChatsBloc(sl()));

  sl.registerFactory<ChatBloc>(() => ChatBloc(sl(), sl()));
}
