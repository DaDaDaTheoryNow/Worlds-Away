import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/core/helpers/remove_non_english_letters.dart';

import 'package:worlds_away/features/user/search/presentation/blocs/search_bloc.dart';
import 'package:worlds_away/features/user/search/presentation/blocs/search_event.dart';

import 'package:worlds_away/features/user/search/presentation/widgets/searched_users.dart';

class UsersSearchPage extends StatefulWidget {
  const UsersSearchPage({super.key});

  @override
  State<UsersSearchPage> createState() => _UsersSearchPageState();
}

class _UsersSearchPageState extends State<UsersSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(42)),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (query) {
          String idToSearch = query.toLowerCase().trim();

          if (idToSearch[0] != "@") {
            String parsedIdToSearch = removeNonEnglishLetters(idToSearch);
            idToSearch = "@$parsedIdToSearch";
          }

          BlocProvider.of<SearchBloc>(context)
              .add(GetSearchedUsersStream(idToSearch));
        },
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Искать пользователей...",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return const SearchedUsers();
  }
}
