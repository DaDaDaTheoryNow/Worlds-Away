import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/data/models/user.dart';
import 'package:worlds_away/features/user/profile/data/data_sources/remote/remote_profile_repository.dart';

class RemoteProfileRepositoryImpl implements RemoteProfileRepository {
  final SharedPreferences prefs;
  final FirebaseFirestore _firestore;

  RemoteProfileRepositoryImpl(this.prefs, this._firestore);

  @override
  Stream<UserModel> getUserProfileStream(String userUniqueId) {
    final userRef =
        _firestore.collection(firestoreCollectionUsers).doc(userUniqueId);

    return userRef.snapshots().map((userSnapshot) {
      final Map<String, dynamic>? userData = userSnapshot.data();

      return UserModel(
        email: userData!["email"] ?? "Unknown",
        id: userData["id"] ?? "Unknown",
        uniqueUid: userData["uniqueUid"] ?? "Unknown",
        name: userData["name"] ?? "Unknown",
        about: userData["about"] ?? "Unknown",
        photoUrl: userData["photoUrl"] ?? "Unknown",
      );
    });
  }
}
