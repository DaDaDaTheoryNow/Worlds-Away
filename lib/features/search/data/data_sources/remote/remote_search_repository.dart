import 'package:worlds_away/features/search/data/models/users.dart';

abstract class RemoteSearchRepository {
  Stream<UsersModel> getSearchedUsersStream(String id);
}
