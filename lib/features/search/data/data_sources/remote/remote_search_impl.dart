import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/data/models/user.dart';
import 'package:worlds_away/features/search/data/data_sources/remote/remote_search_repository.dart';
import 'package:worlds_away/features/search/data/models/users.dart';

class RemoteSearchImpl implements RemoteSearchRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteSearchImpl(this._firestore, this._auth);

  @override
  Stream<UsersModel> getSearchedUsersStream(String id) {
    final user = _auth.currentUser;
    final userRef = _firestore.collection(firestoreCollectionUsers);

    return userRef
        .where("id", isEqualTo: id)
        .get(const GetOptions(source: Source.server))
        .asStream()
        .map((usersSnapshot) {
      final List<DocumentSnapshot> userDocs = usersSnapshot.docs;
      final List<UserModel> usersList = userDocs.map((doc) {
        return UserModel.fromSnapshot(doc);
      }).toList();

      usersList.removeWhere((element) => element.uniqueUid == user!.uid);

      return UsersModel(usersList: usersList);
    });
  }
}
