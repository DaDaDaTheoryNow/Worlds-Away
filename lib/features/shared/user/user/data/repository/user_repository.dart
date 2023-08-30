import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/user/user/data/data_sources/remote_user_repository.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';
import 'package:worlds_away/features/shared/user/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteUserRepository _remoteUserRepository;
  UserRepositoryImpl(this._remoteUserRepository);

  @override
  Future<DataState<UserModel?>> getUserInformation() async {
    try {
      final UserModel? userModel =
          await _remoteUserRepository.getUserInformation();

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
}
