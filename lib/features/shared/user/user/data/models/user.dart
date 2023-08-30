import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? email,
    final String? uniqueUid,
    final String? id,
    final String? name,
    final String? photoUrl,
    final String? about,
    final bool? isOnline,
    final String? fcmToken,
  }) : super(
          id: id,
          uniqueUid: uniqueUid,
          name: name,
          email: email,
          about: about,
          photoUrl: photoUrl,
          isOnline: isOnline,
          fcmToken: fcmToken,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    return UserModel(
        email: data!["email"],
        uniqueUid: data["uniqueUid"],
        id: data["id"],
        name: data["name"],
        photoUrl: data["photoUrl"],
        about: data["about"],
        isOnline: data["isOnline"],
        fcmToken: data["fcmToken"]);
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
        email: userEntity.email,
        uniqueUid: userEntity.uniqueUid,
        id: userEntity.id,
        name: userEntity.name,
        photoUrl: userEntity.photoUrl,
        about: userEntity.about,
        isOnline: userEntity.isOnline,
        fcmToken: userEntity.fcmToken);
  }
}
