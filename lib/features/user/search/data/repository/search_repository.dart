import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/user/search/data/data_sources/remote/remote_search_repository.dart';
import 'package:worlds_away/features/user/search/domain/entity/users.dart';
import 'package:worlds_away/features/user/search/domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final RemoteSearchRepository _remoteSearchRepository;

  SearchRepositoryImpl(this._remoteSearchRepository);

  @override
  DataState<Stream<UsersEntity>> getSearchedUsersStream(String id) {
    try {
      final searchedUsersStream =
          _remoteSearchRepository.getSearchedUsersStream(id);
      return DataSuccess(searchedUsersStream);
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        return const DataFailed("Error: Нужно Интернет Соединение");
      } else {
        return DataFailed("Error: ${e.message}");
      }
    }
  }
}
