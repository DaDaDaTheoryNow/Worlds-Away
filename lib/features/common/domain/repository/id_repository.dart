import 'package:worlds_away/core/resources/data_state.dart';

abstract class IdRepository {
  Future<DataState<bool>> checkIdAvailable(String id);
}
