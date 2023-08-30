import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/shared/user/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<UserEntity?>> getUserInformation();
}
