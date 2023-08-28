import 'package:worlds_away/core/resources/data_state.dart';

import 'package:worlds_away/core/usecase/usecase.dart';

import 'package:worlds_away/features/search/domain/entity/users.dart';
import 'package:worlds_away/features/search/domain/repository/search_repository.dart';

class GetSearchedUsersStreamUseCase
    implements UseCase<DataState<Stream<UsersEntity>>, String> {
  final SearchRepository _searchRepository;

  GetSearchedUsersStreamUseCase(this._searchRepository);

  @override
  Future<DataState<Stream<UsersEntity>>> call({String? params}) async {
    return _searchRepository.getSearchedUsersStream(params!);
  }
}
