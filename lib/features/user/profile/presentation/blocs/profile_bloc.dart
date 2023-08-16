import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/features/user/profile/domain/usecases/get_user_profile.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_event.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;

  ProfileBloc(this._getUserProfileUseCase) : super(ProfileLoading()) {
    on<GetUserProfile>(_onGetUserProfile);
  }

  void _onGetUserProfile(
      GetUserProfile event, Emitter<ProfileState> emit) async {
    final dataState = await _getUserProfileUseCase();

    if (dataState is UserInformationDataSuccess) {
      emit(ProfileDone(dataState.user!));
    } else if (dataState is UserInformationDataError) {
      emit(ProfileError(dataState.error!));
    }
  }
}
