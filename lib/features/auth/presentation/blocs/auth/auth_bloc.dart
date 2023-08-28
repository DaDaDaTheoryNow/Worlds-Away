import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:worlds_away/features/auth/domain/usecases/sign_out_and_clear_user_setup_bool.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInOutAndClearUserSetupBoolUseCase
      _signInOutAndClearUserSetupBoolUseCase;

  AuthBloc(this._signInWithGoogleUseCase,
      this._signInOutAndClearUserSetupBoolUseCase)
      : super(const UserSignOut()) {
    on<SignIn>(onSignIn);
    on<SignOut>(onSignOut);
  }

  Future<void> onSignIn(SignIn event, Emitter emit) async {
    emit(const AuthLoading());

    final dataState = await _signInWithGoogleUseCase();

    if (dataState is DataSuccess && dataState.data != null) {
      emit(UserSignIn(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }

  void onSignOut(SignOut event, Emitter emit) async {
    final dataState = await _signInOutAndClearUserSetupBoolUseCase();

    if (dataState is DataSuccess && dataState.data == null) {
      emit(const UserSignOut());
    }

    if (dataState is DataFailed) {
      emit(AuthError(dataState.error!));
    }
  }
}
