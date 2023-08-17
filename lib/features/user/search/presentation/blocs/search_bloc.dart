import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/resources/users_information_data_state.dart';
import 'package:worlds_away/features/user/search/domain/usecases/get_searched_users_stream.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_event.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchedUsersStreamUseCase _getSearchedUsersStreamUseCase;

  SearchBloc(this._getSearchedUsersStreamUseCase) : super(const SearchState()) {
    on<GetSearchedUsersStream>(onGetSearchedUsersStream);
    on<ResetSearchState>(onResetSearchState);
  }

  void onGetSearchedUsersStream(
      GetSearchedUsersStream event, Emitter emit) async {
    emit(SearchLoading());
    final dataState = await _getSearchedUsersStreamUseCase(params: event.id);

    if (dataState is UsersInformationDataSuccess) {
      emit(SearchDone(dataState.users!));
    }

    if (dataState is UsersInformationDataError) {
      emit(SearchError(dataState.error!));
    }
  }

  void onResetSearchState(ResetSearchState event, Emitter emit) {
    emit(const SearchState());
  }
}
