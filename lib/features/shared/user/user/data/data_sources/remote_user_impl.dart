import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/user/user/data/data_sources/remote_user_repository.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

class RemoteUserImpl implements RemoteUserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  RemoteUserImpl(this._auth, this._firestore);

  @override
  Future<UserModel?> getUserInformation() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      final userSnapshot =
          await userRef.get(const GetOptions(source: Source.server));
      final Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        return UserModel(
            email: userData["email"],
            id: userData["id"],
            uniqueUid: userData["uniqueUid"],
            name: userData["name"],
            about: userData["about"],
            photoUrl: userData["photoUrl"],
            isOnline: userData["isOnline"]);
      }
    }

    return null;
  }
}
