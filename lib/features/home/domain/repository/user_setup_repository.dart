import 'package:worlds_away/core/resources/id_available_data_state.dart';
import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/features/home/domain/entities/user_setup_information.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

abstract class UserSetupRepository {
  Future<UserSetupDataState> getUserSetupState();
  Future<void> setUserSetupBool(bool value);

  Future<UserSetupDataState> sendUserSetupInformation(
      UserSetupInformationEntity informationEntity);

  Future<UserInformationDataState<UserEntity?>> getUserInformation();

  UserEntity getUserLocalInformation();

  Future<IdAvailableleDataState<bool>> checkIdAvailable(String id);
}
