import 'dart:io';

import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

abstract class RemoteProfileRepository {
  Stream<UserModel> getUserProfileStream(String userUniqueId);

  Future<void> changeName(String name);
  Future<void> changeAbout(String about);
  Future<void> changeId(String id);
  Future<void> changeAvatar(File file);
}
