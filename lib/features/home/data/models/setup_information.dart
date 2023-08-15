import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worlds_away/features/home/domain/entity/user_setup_information.dart';

part 'setup_information.freezed.dart';

@freezed
class UserSetupInformationModel extends UserSetupInformationEntity
    with _$UserSetupInformationModel {
  const factory UserSetupInformationModel({
    String? email,
    String? uniqueUid,
    String? id,
    String? name,
    String? photoUrl,
    String? about,
  }) = _UserSetupInformationModel;

  factory UserSetupInformationModel.fromEntity(
      UserSetupInformationEntity entity) {
    return UserSetupInformationModel(
      id: entity.id,
      name: entity.name,
      about: entity.about,
    );
  }
}
