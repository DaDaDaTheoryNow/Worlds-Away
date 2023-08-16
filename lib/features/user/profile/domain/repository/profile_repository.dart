import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/features/common/domain/entity/user.dart';

abstract class ProfileRepository {
  UserInformationDataState<Stream<UserEntity>> getUserProfileStream();
}
