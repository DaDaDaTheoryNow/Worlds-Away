import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

abstract class ProfileRepository {
  DataState<Stream<UserEntity>> getUserProfileStream(String userUniqueId);

  Future<DataState<void>> changeName(String name);
  Future<DataState<void>> changeAbout(String about);
  Future<DataState<void>> changeId(String id);
}
