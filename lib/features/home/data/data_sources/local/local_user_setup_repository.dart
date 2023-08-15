import 'package:worlds_away/features/home/data/models/user.dart';

abstract class LocalUserSetupRepository {
  bool getHasUserSetup();
  Future<void> setUserSetupBool(bool value);
  UserModel getUserLocalInformation();
}
