import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

abstract class RemoteUserRepository {
  Future<UserModel?> getUserInformation();
}
