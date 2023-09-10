import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/profile/domain/usecases/change_avatar.dart';

import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';
import 'package:worlds_away/features/profile/domain/usecases/get_user_profile.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_event.dart';
import 'package:worlds_away/features/profile/presentation/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final ChangeAvatarUseCase _changeAvatarUseCase;
  final FirebaseAuth _auth;

  ProfileBloc(
      this._getUserProfileUseCase, this._changeAvatarUseCase, this._auth)
      : super(ProfileLoading()) {
    on<GetCurrentUserProfile>(_onGetCurrentUserProfile);
    on<ChangeAvatar>(_onChangeAvatar);
  }

  void _onGetCurrentUserProfile(
      GetCurrentUserProfile event, Emitter<ProfileState> emit) async {
    final dataState =
        await _getUserProfileUseCase(params: _auth.currentUser!.uid);

    if (dataState is DataSuccess) {
      await emit.forEach(dataState.data!, onData: (UserEntity data) {
        return ProfileDone(data);
      });
    }

    if (dataState is DataFailed) {
      emit(ProfileError(dataState.error!));
    }
  }

  void _onChangeAvatar(ChangeAvatar event, Emitter emit) async {
    final dataState = await _changeAvatarUseCase();

    if (dataState is DataFailed) {
      emit(ProfileError(dataState.error!));
    }
  }
}
