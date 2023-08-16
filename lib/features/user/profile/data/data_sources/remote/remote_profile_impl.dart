import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/data/models/user.dart';
import 'package:worlds_away/features/user/profile/data/data_sources/remote/remote_profile_repository.dart';

class RemoteProfileRepositoryImpl implements RemoteProfileRepository {
  final SharedPreferences prefs;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  RemoteProfileRepositoryImpl(this.prefs, this._auth, this._firestore);

  @override
  Stream<UserModel> getUserProfileStream() {
    final user = _auth.currentUser;

    final userRef =
        _firestore.collection(firestoreCollectionUsers).doc(user!.uid);

    return userRef.snapshots().map((userSnapshot) {
      final Map<String, dynamic>? userData = userSnapshot.data();

      return UserModel(
        email: _auth.currentUser!.email,
        id: userData!["id"] ?? "Unknown",
        uniqueUid: _auth.currentUser!.uid,
        name: userData["name"] ?? "Unknown",
        about: userData["about"] ?? "Unknown",
        photoUrl: userData["photoUrl"] ?? "Unknown",
      );
    });
  }
}
