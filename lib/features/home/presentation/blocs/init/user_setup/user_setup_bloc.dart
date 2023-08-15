import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_local_information.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_setup_state.dart';
import 'package:worlds_away/features/home/domain/usecases/set_user_setup_bool.dart';
import 'package:worlds_away/features/home/presentation/blocs/init/user_setup/user_setup_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/init/user_setup/user_setup_state.dart';

class UserSetupBloc extends Bloc<UserSetupEvent, UserSetupState> {
  final GetUserSetupStateUseCase _getUserSetupUseCase;
  final SetUserSetupBoolUseCase _setUserSetupBoolUseCase;
  final GetUserLocalInformationUseCase _getUserLocalInformationUseCase;

  UserSetupBloc(this._getUserSetupUseCase, this._setUserSetupBoolUseCase,
      this._getUserLocalInformationUseCase)
      : super(UserSetupLoading()) {
    on<GetUserSetup>(onGetUserSetup);
  }

  Future<void> onGetUserSetup(GetUserSetup event, Emitter emit) async {
    emit(UserSetupLoading());

    final dataState = await _getUserSetupUseCase();
    final userPhotoURL = await _getUserLocalInformationUseCase
        .call()
        .then((value) => value.photoUrl);

    if (dataState is UserSetupDataSuccess) {
      await _setUserSetupBoolUseCase(params: true);
      emit(UserSetupState(
        status: UserSetupStatus.filled,
        photoUrl: userPhotoURL ?? "",
      ));
    }

    if (dataState is UserSetupDataFailed) {
      emit(const UserSetupState(
        status: UserSetupStatus.empty,
      ));
    }

    if (dataState is UserSetupDataError) {
      emit(UserSetupError(dataState.error!));
    }
  }
}
