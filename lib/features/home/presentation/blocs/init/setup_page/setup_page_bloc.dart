import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/id_available_data_state.dart';
import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/features/home/domain/entity/user.dart';
import 'package:worlds_away/features/home/domain/entity/user_setup_information.dart';
import 'package:worlds_away/features/home/domain/usecases/check_id_available.dart';
import 'package:worlds_away/features/home/domain/usecases/get_user_information.dart';
import 'package:worlds_away/features/home/domain/usecases/send_user_setup_information.dart';
import 'package:worlds_away/features/home/domain/usecases/set_user_setup_bool.dart';
import 'package:worlds_away/features/home/presentation/blocs/init/setup_page/setup_page_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/init/setup_page/setup_page_state.dart';

class SetupPageBloc extends Bloc<SetupPageEvent, SetupPageState> {
  final GetUserInformationUseCase _getUserInformationUseCase;
  final SendUserSetupInformationUseCase _sendUserSetupInformationUseCase;
  final CheckIdAvailableUseCase _checkIdAvailableUseCase;
  final SetUserSetupBoolUseCase _setUserSetupBoolUseCase;

  SetupPageBloc(
      this._getUserInformationUseCase,
      this._sendUserSetupInformationUseCase,
      this._checkIdAvailableUseCase,
      this._setUserSetupBoolUseCase)
      : super(SetupPageLoading()) {
    on<CheckIdAvailable>(onCheckIdAvailable);
    on<SendSetupInformation>(onSendUserSetupInformation);
    on<GetSetupPageInformation>(onGetSetupPageInformation);
  }

  Future<void> onCheckIdAvailable(CheckIdAvailable event, Emitter emit) async {
    emit(SetupPageLoading());

    final dataState =
        await _checkIdAvailableUseCase(params: event.idForAvailableCheck);

    if (dataState is IdAvailableSuccess) {
      final getUserInformationDataState = await _getUserInformationUseCase();
      final UserEntity? user =
          await getUserInformation(getUserInformationDataState);

      emit(SetupPageDone(user, dataState.isAvailable));
    } else {
      emit(SetupPageError(dataState.error!));
    }
  }

  Future<void> onSendUserSetupInformation(
      SendSetupInformation event, Emitter emit) async {
    final dataState = await _sendUserSetupInformationUseCase(
        params: UserSetupInformationEntity(
            id: event.id, name: event.name, about: event.about));

    if (dataState is UserSetupDataSuccess) {
      await _setUserSetupBoolUseCase(params: true);
      emit(SetupPageSendInformationDone());
    } else {
      emit(SetupPageError(dataState.error!));
    }
  }

  Future<void> onGetSetupPageInformation(
      GetSetupPageInformation event, Emitter emit) async {
    final dataState = await _getUserInformationUseCase();
    final UserEntity? user = await getUserInformation(dataState);

    if (user != null) {
      emit(SetupPageDone(user, null));
    } else {
      emit(SetupPageError(dataState.error!));
    }
  }

  Future<UserEntity?> getUserInformation(
      UserInformationDataState<UserEntity?> dataState) async {
    if (dataState is UserInformationDataSuccess) {
      return dataState.user!;
    } else {
      return null;
    }
  }
}
