import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/search/domain/entity/users.dart';

class SearchState extends Equatable {
  final UsersEntity? users;

  final String? error;

  const SearchState({this.users, this.error});

  @override
  List<Object?> get props => [users, error];
}

class SearchLoading extends SearchState {}

class SearchDone extends SearchState {
  const SearchDone(UsersEntity? users) : super(users: users);
}

class SearchError extends SearchState {
  const SearchError(String error) : super(error: error);
}
