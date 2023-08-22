import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/data/data_sources/remote_user_online_repository.dart';

class RemoteUserOnlineImpl implements RemoteUserOnlineRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteUserOnlineImpl(this._auth, this._firestore);

  @override
  Future<void> updateUserOnlineStatus(bool isOnline) async {
    final user = _auth.currentUser;

    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      await userRef.set({
        'isOnline': isOnline,
      }, SetOptions(merge: true));
    }
  }
}
