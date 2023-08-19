import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';

abstract class ProfileRepository {
  DataState<Stream<UserEntity>> getUserProfileStream(String userUniqueId);
}
