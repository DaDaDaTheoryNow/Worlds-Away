import 'package:worlds_away/features/home/data/models/setup_information.dart';
import 'package:worlds_away/features/shared/user/user/data/models/user.dart';

abstract class RemoteUserSetupRepository {
  Future<UserModel?> getUserSetupModel();
  Future<void> sendUserSetupInformation(
      UserSetupInformationModel userSetupInformationModel);

  Future<UserModel?> getUserInformation();
}
