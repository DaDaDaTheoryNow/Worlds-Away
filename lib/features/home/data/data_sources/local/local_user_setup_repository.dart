import 'package:worlds_away/features/common/data/models/user.dart';

abstract class LocalUserSetupRepository {
  bool getHasUserSetup();
  Future<void> setUserSetupBool(bool value);
  UserModel getUserLocalInformation();
}
