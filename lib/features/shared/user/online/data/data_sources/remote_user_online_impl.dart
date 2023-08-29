import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/user/online/data/data_sources/remote_user_online_repository.dart';
import 'package:worlds_away/features/shared/user/online/data/models/user_online.dart';

class RemoteUserOnlineImpl implements RemoteUserOnlineRepository {
  final FirebaseFirestore _firestore;

  RemoteUserOnlineImpl(this._firestore);

  @override
  Future<void> updateUserOnlineStatus(UserOnlineModel userOnlineModel) async {
    final userRef = _firestore
        .collection(firestoreCollectionUsers)
        .doc(userOnlineModel.uniqueUid);

    await userRef.update({
      'isOnline': userOnlineModel.isOnline,
    });
  }
}
