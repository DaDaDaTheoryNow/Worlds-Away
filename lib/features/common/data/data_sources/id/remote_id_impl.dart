import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/common/data/data_sources/id/remote_id_repository.dart';

class RemoteIdImpl implements RemoteIdRepository {
  final FirebaseFirestore _firestore;

  RemoteIdImpl(this._firestore);

  @override
  Future<bool?> checkIdAvailable(String id) async {
    final userCollection = _firestore.collection(firestoreCollectionUsers);
    final querySnapshot =
        await userCollection.get(const GetOptions(source: Source.server));

    for (final docSnapshot in querySnapshot.docs) {
      final Map<String, dynamic> userData = docSnapshot.data();
      if (userData['id'] == id) {
        return false;
      }
    }

    return true;
  }
}
