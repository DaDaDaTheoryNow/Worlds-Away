import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/auth/data/data_sources/local/shared_preferences/local_auth_repository.dart';

class LocalAuthImpl implements LocalAuthRepository {
  final SharedPreferences prefs;

  LocalAuthImpl(this.prefs);

  @override
  Future<void> clearUserSetupBool() async {
    await prefs.remove(prefsHasUserDescriptionKey);
  }
}
