import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';
import 'package:worlds_away/features/profile/data/data_sources/remote/remote_profile_repository.dart';
import 'package:worlds_away/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RemoteProfileRepository _remoteProfileRepository;

  ProfileRepositoryImpl(this._remoteProfileRepository);

  @override
  DataState<Stream<UserModel>> getUserProfileStream(String userUniqueId) {
    try {
      final userInformationStream =
          _remoteProfileRepository.getUserProfileStream(userUniqueId);
      return DataSuccess(userInformationStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState<void>> changeAbout(String about) async {
    try {
      await _remoteProfileRepository.changeAbout(about);
      return const DataSuccess(null);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState<void>> changeName(String name) async {
    try {
      await _remoteProfileRepository.changeName(name);
      return const DataSuccess(null);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState<void>> changeId(String id) async {
    try {
      await _remoteProfileRepository.changeId(id);
      return const DataSuccess(null);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }

  @override
  Future<DataState<void>> changeAvatar() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        await _remoteProfileRepository.changeAvatar(file);
        return const DataSuccess(null);
      } on FirebaseException catch (e) {
        if (e.code == 'unavailable') {
          return const DataFailed("Error: Нужно Интернет Соединение");
        } else {
          return DataFailed("Error: ${e.message}");
        }
      }
    }
    return DataFailed("Error: Изображение было не выбрано");
  }
}
