import 'package:worlds_away/core/resources/users_information_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';

import 'package:worlds_away/features/user/search/domain/entity/users.dart';
import 'package:worlds_away/features/user/search/domain/repository/search_repository.dart';

class GetSearchedUsersStreamUseCase
    implements UseCase<UsersInformationDataState<Stream<UsersEntity>>, String> {
  final SearchRepository _searchRepository;

  GetSearchedUsersStreamUseCase(this._searchRepository);

  @override
  Future<UsersInformationDataState<Stream<UsersEntity>>> call(
      {String? params}) async {
    return _searchRepository.getSearchedUsersStream(params!);
  }
}
