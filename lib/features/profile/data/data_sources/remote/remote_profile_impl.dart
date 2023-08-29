import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';
import 'package:worlds_away/features/profile/data/data_sources/remote/remote_profile_repository.dart';

class RemoteProfileRepositoryImpl implements RemoteProfileRepository {
  final SharedPreferences prefs;
  final FirebaseFirestore _firestore;

  final FirebaseAuth _auth;

  RemoteProfileRepositoryImpl(this.prefs, this._firestore, this._auth);

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

  @override
  Future<void> changeAbout(String about) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      await userRef.update({
        "about": about,
      });
    }
  }

  @override
  Future<void> changeName(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      await userRef.update({
        "name": name,
      });
    }
  }

  @override
  Future<void> changeId(String id) async {
    final user = _auth.currentUser;
    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      await userRef.update({
        "id": id,
      });
    }
  }
}
