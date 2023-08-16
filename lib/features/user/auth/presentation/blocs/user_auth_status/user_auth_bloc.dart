import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worlds_away/core/resources/user_auth_status_state.dart';
import 'package:worlds_away/features/user/auth/domain/usecases/check_user_auth_status.dart';

import 'package:worlds_away/features/user/auth/presentation/blocs/user_auth_status/user_auth_event.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/user_auth_status/user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final CheckUserAuthStatusUseCase _checkUserAuthStatusUseCase;

  UserAuthBloc(this._checkUserAuthStatusUseCase)
      : super(const UserAuthState(status: UserAuthStatus.unknown)) {
    on<CheckUserAuthStatus>(onCheckUserAuthStatus);
  }

  void onCheckUserAuthStatus(CheckUserAuthStatus event, Emitter emit) async {
    final Stream<UserAuthStatusState<User?>> userAuthStatusState =
        await _checkUserAuthStatusUseCase();

    await for (final status in userAuthStatusState) {
      if (status is UserAuthenticated && status.user != null) {
        emit(UserAuthState(
            status: UserAuthStatus.authenticated, user: status.user));
      } else {
        emit(const UserAuthState(status: UserAuthStatus.unauthenticated));
      }
    }
  }
}
