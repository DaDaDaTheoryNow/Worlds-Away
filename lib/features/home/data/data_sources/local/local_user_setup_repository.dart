import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

abstract class LocalUserSetupRepository {
  bool getHasUserSetup();
  Future<void> setUserSetupBool(bool value);
  UserModel getUserLocalInformation();
}
