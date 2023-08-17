import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_bloc.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_state.dart';
import 'package:worlds_away/features/user/search/presentation/widgets/searched_user_tile.dart';

class SearchedUsers extends StatelessWidget {
  const SearchedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const CupertinoLoading();
        }

        if (state is SearchDone) {
          return StreamBuilder(
            stream: state.users,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const MyErrorWidget(
                  error: 'Error: нужно Интернет Соединение',
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoLoading();
              }

              if (snapshot.hasData) {
                final usersList = snapshot.data!.usersList;

                if (usersList!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Не найдено ни одного пользователя",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    final searchedUser = usersList[index];
                    return SearchedUserTile(user: searchedUser);
                  },
                );
              }

              return const SizedBox();
            },
          );
        }

        if (state is SearchError) {
          return MyErrorWidget(error: state.error!);
        }

        return const Center(
          child: Text(
            "Введите идентификатор пользователя для поиска",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
