import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/common/domain/usecases/check_id_available.dart';

import 'package:worlds_away/features/user/profile/domain/usecases/change_about.dart';
import 'package:worlds_away/features/user/profile/domain/usecases/change_id.dart';
import 'package:worlds_away/features/user/profile/domain/usecases/change_name.dart';

import 'change_event.dart';
import 'change_state.dart';

class ChangeBloc extends Bloc<ChangeEvent, ChangeState> {
  final ChangeNameUseCase _changeNameUseCase;
  final ChangeAboutUseCase _changeAboutUseCase;
  final ChangeIdUseCase _changeIdUseCase;
  final CheckIdAvailableUseCase _checkIdAvailableUseCase;

  ChangeBloc(this._changeNameUseCase, this._changeAboutUseCase,
      this._checkIdAvailableUseCase, this._changeIdUseCase)
      : super(const ChangeState()) {
    on<ChangeName>(_onChangeName);
    on<ChangeAbout>(_onChangeAbout);
    on<ChangeId>(_onChangeId);
    on<ChangeInititState>(_onChangeInitialState);
    on<ChangeCheckIdAvailable>(_onChangeCheckIdAvailable);
  }

  void _onChangeCheckIdAvailable(
      ChangeCheckIdAvailable event, Emitter emit) async {
    emit(ChangeLoading());

    final dataState = await _checkIdAvailableUseCase(params: event.id);

    if (dataState is DataSuccess) {
      emit(ChangeState(idAvailableStatus: dataState.data!));
    } else {
      emit(ChangeError(dataState.error!));
    }
  }

  void _onChangeName(ChangeName event, Emitter emit) async {
    emit(ChangeLoading());

    final dataState = await _changeNameUseCase(params: event.name);

    if (dataState is DataSuccess) {
      emit(ChangeDone());
    }

    if (dataState is DataFailed) {
      emit(ChangeError(dataState.error!));
    }
  }

  void _onChangeAbout(ChangeAbout event, Emitter emit) async {
    emit(ChangeLoading());

    final dataState = await _changeAboutUseCase(params: event.about);

    if (dataState is DataSuccess) {
      emit(ChangeDone());
    }

    if (dataState is DataFailed) {
      emit(ChangeError(dataState.error!));
    }
  }

  void _onChangeId(ChangeId event, Emitter emit) async {
    emit(ChangeLoading());

    final dataState = await _changeIdUseCase(params: event.id);

    if (dataState is DataSuccess) {
      emit(ChangeDone());
    }

    if (dataState is DataFailed) {
      emit(ChangeError(dataState.error!));
    }
  }

  void _onChangeInitialState(ChangeInititState event, Emitter emit) =>
      emit(const ChangeState());
}
