import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/home/data/models/setup_information.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

import 'remote_user_setup_repository.dart';

class RemoteUserSetupImpl implements RemoteUserSetupRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  RemoteUserSetupImpl(this._auth, this._firestore);

  @override
  Future<UserModel?> getUserSetupModel() async {
    final user = _auth.currentUser;

    if (user != null) {
      final userRef =
          _firestore.collection(firestoreCollectionUsers).doc(user.uid);

      final userSnapshot =
          await userRef.get(const GetOptions(source: Source.server));
      final Map<String, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        final userModel = UserModel(
          id: userData["id"],
          name: userData["name"],
        );

        if (userModel.id != null &&
            userModel.name != null &&
            userModel.name!.isNotEmpty &&
            userModel.id!.isNotEmpty) {
          return userModel;
        }
      }
    }

    return null;
  }

  @override
  Future<void> sendUserSetupInformation(
      UserSetupInformationModel userSetupInformationModel) async {
    final user = _auth.currentUser;

    final userRef =
        _firestore.collection(firestoreCollectionUsers).doc(user!.uid);

    await userRef.set({
      'id': userSetupInformationModel.id,
      'name': userSetupInformationModel.name,
      'about': userSetupInformationModel.about,
      'photoUrl': user.photoURL ?? "",
    }, SetOptions(merge: true));
  }
}
