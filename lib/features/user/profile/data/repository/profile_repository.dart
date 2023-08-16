import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/features/common/data/models/user.dart';
import 'package:worlds_away/features/user/profile/data/data_sources/remote/remote_profile_repository.dart';
import 'package:worlds_away/features/user/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RemoteProfileRepository _remoteProfileRepository;

  ProfileRepositoryImpl(this._remoteProfileRepository);

  @override
  UserInformationDataState<Stream<UserModel>> getUserProfileStream() {
    try {
      final userInformationStream =
          _remoteProfileRepository.getUserProfileStream();
      return UserInformationDataSuccess(userInformationStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const UserInformationDataError(
            "Error: Нужно Интернет Соединение");
      } else {
        return UserInformationDataError("Error: ${e.message}");
      }
    }
  }
}
