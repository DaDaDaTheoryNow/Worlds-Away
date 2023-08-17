import 'package:worlds_away/features/home/domain/entities/user_setup_information.dart';

class UserSetupInformationModel extends UserSetupInformationEntity {
  const UserSetupInformationModel({
    String? id,
    String? name,
    String? about,
  }) : super(id: id, name: name, about: about);

  factory UserSetupInformationModel.fromEntity(
      UserSetupInformationEntity entity) {
    return UserSetupInformationModel(
      id: entity.id,
      name: entity.name,
      about: entity.about,
    );
  }
}
