import 'package:worlds_away/features/common/data/models/user.dart';

abstract class RemoteProfileRepository {
  Stream<UserModel> getUserProfileStream(String userUniqueId);

  Future<void> changeName(String name);
  Future<void> changeAbout(String about);
}
