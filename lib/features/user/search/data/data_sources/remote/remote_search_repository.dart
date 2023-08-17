import 'package:worlds_away/features/user/search/data/models/users.dart';

abstract class RemoteSearchRepository {
  Stream<UsersModel> getSearchedUsersStream(String id);
}
