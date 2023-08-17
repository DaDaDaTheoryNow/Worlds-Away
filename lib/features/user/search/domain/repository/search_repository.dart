import 'package:worlds_away/core/resources/users_information_data_state.dart';
import 'package:worlds_away/features/user/search/domain/entity/users.dart';

abstract class SearchRepository {
  UsersInformationDataState<Stream<UsersEntity>> getSearchedUsersStream(
      String id);
}
