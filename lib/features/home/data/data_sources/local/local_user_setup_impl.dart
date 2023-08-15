import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/home/data/data_sources/local/local_user_setup_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/features/home/data/models/user.dart';

class LocalUserSetupImpl implements LocalUserSetupRepository {
  final SharedPreferences prefs;
  final FirebaseAuth _auth;

  LocalUserSetupImpl(this.prefs, this._auth);

  @override
  bool getHasUserSetup() {
    final bool hasUserDescription =
        prefs.getBool(prefsHasUserDescriptionKey) ?? false;

    return hasUserDescription;
  }

  @override
  Future<void> setUserSetupBool(bool value) async {
    await prefs.setBool(prefsHasUserDescriptionKey, value);
  }

  @override
  UserModel getUserLocalInformation() {
    final user = _auth.currentUser;

    return UserModel(
      uniqueUid: user!.uid,
      email: user.email,
      photoUrl: user.photoURL,
    );
  }
}
