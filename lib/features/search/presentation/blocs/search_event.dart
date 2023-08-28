import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  final String? id;

  const SearchEvent({this.id});

  @override
  List<Object?> get props => [id];
}

class GetSearchedUsersStream extends SearchEvent {
  const GetSearchedUsersStream(String id) : super(id: id);
}

class ResetSearchState extends SearchEvent {}
