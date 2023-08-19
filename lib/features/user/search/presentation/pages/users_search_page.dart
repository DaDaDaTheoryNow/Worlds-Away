import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (query) {
          final String idToSearch = "@${query.toLowerCase().trim()}";
          BlocProvider.of<SearchBloc>(context)
              .add(GetSearchedUsersStream(idToSearch));
        },
        decoration: InputDecoration(
          hintText: "Искать пользователей...",
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixText: _isSearching ? "@" : "",
          prefixStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return const SearchedUsers();
  }
}
