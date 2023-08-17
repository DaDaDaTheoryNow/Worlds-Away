import 'package:worlds_away/core/resources/user_information_data_state.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

abstract class ProfileRepository {
  UserInformationDataState<Stream<UserEntity>> getUserProfileStream(
      String userUniqueId);
}
