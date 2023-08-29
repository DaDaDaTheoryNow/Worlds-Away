import 'package:worlds_away/features/shared/user/online/domain/entities/user_online.dart';

class UserOnlineModel extends UserOnlineEntity {
  const UserOnlineModel({
    required String uniqueUid,
    required bool isOnline,
  }) : super(
          uniqueUid: uniqueUid,
          isOnline: isOnline,
        );

  factory UserOnlineModel.fromEntity(UserOnlineEntity userOnlineEntity) {
    return UserOnlineModel(
        uniqueUid: userOnlineEntity.uniqueUid,
        isOnline: userOnlineEntity.isOnline);
  }
}
