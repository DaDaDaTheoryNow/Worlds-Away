import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/features/home/data/data_sources/local/local_user_setup_repository.dart';
import 'package:worlds_away/features/home/data/data_sources/remote/remote_user_setup_repository.dart';
import 'package:worlds_away/features/home/data/models/setup_information.dart';

import 'package:worlds_away/features/home/domain/entities/user_setup_information.dart';

import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

class UserSetupRepositoryImpl implements UserSetupRepository {
  final LocalUserSetupRepository _localSetupRepository;
  final RemoteUserSetupRepository _remoteSetupRepository;

  UserSetupRepositoryImpl(
      this._localSetupRepository, this._remoteSetupRepository);

  @override
  Future<UserSetupDataState> getUserSetupState() async {
    final hasUserDescription = _localSetupRepository.getHasUserSetup();

    if (!hasUserDescription) {
      try {
        final UserModel? userModel =
            await _remoteSetupRepository.getUserSetupModel();

        if (userModel == null) {
          return const UserSetupDataFailed();
        } else {
          return const UserSetupDataSuccess();
        }
      } on FirebaseException catch (e) {
        if (e.code == 'unavailable') {
          return const UserSetupDataError(
              "Error: При первом входе нужно Интернет Соединение");
        } else {
          return UserSetupDataError("Error: ${e.message}");
        }
      }
    }

    return const UserSetupDataSuccess();
  }

  @override
  Future<void> setUserSetupBool(bool value) async {
    await _localSetupRepository.setUserSetupBool(value);
  }

  @override
  Future<UserSetupDataState> sendUserSetupInformation(
      UserSetupInformationEntity informationEntity) async {
    final UserSetupInformationModel userSetupInformationModel =
        UserSetupInformationModel.fromEntity(informationEntity);

    try {
      await _remoteSetupRepository
          .sendUserSetupInformation(userSetupInformationModel);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const UserSetupDataError("Error: Нужно Интернет Соединение");
      } else {
        return UserSetupDataError("Error: ${e.message}");
      }
    }

    return const UserSetupDataSuccess();
  }

  @override
  Future<DataState<UserModel?>> getUserInformation() async {
    try {
      final UserModel? userModel =
          await _remoteSetupRepository.getUserInformation();

      if (userModel != null) {
        return DataSuccess(userModel);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }

    return const DataFailed("Error: Пользователь не найден");
  }

  @override
  UserModel getUserLocalInformation() {
    return _localSetupRepository.getUserLocalInformation();
  }
}
