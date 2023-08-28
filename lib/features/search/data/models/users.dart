import 'package:worlds_away/features/common/data/models/user.dart';
import 'package:worlds_away/features/search/domain/entity/users.dart';

class UsersModel extends UsersEntity {
  const UsersModel({List<UserModel>? usersList}) : super(usersList: usersList);
}
