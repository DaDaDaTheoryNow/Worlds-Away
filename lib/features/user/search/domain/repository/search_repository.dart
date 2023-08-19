import 'package:worlds_away/core/resources/data_state.dart';

import 'package:worlds_away/features/user/search/domain/entity/users.dart';

abstract class SearchRepository {
  DataState<Stream<UsersEntity>> getSearchedUsersStream(String id);
}
