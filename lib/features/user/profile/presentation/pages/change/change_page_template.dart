import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_bloc.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/save_button.dart';
import 'package:worlds_away/injection_container.dart';

class ChangePageTemplate extends StatefulWidget {
  final String title;
  final String hintText;
  final Function() onPressed;
  const ChangePageTemplate(
      {required this.title,
      required this.hintText,
      required this.onPressed,
      super.key});

  @override
  State<ChangePageTemplate> createState() => _ChangePageTemplateState();
}

class _ChangePageTemplateState extends State<ChangePageTemplate> {
  final TextEditingController _changeController = TextEditingController();
  double _readyToChangeScale = 0;

  @override
  void dispose() {
    _changeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangeBloc(sl(), sl()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(42)),
                child: TextField(
                  controller: _changeController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (query) {
                    if (query.trim().isNotEmpty) {
                      setState(() {
                        _readyToChangeScale = 1;
                      });
                    } else {
                      setState(() {
                        _readyToChangeScale = 0;
                      });
                    }
                    /*String idToSearch = query.toLowerCase().trim();
    
                  if (idToSearch[0] != "@") {
                    String parsedIdToSearch = removeNonEnglishLetters(idToSearch);
                    idToSearch = "@$parsedIdToSearch";
                  }
    
                  BlocProvider.of<SearchBloc>(context)
                      .add(GetSearchedUsersStream(idToSearch));*/
                  },
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(Icons.edit),
                  ),
                ),
              ),
              AnimatedScale(
                scale: _readyToChangeScale,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInSine,
                child: Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: _buildSaveButton(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      centerTitle: true,
      title: Text(widget.title),
    );
  }

  _buildSaveButton() {
    return SaveButton(onPressed: () {}, title: "Сохранить");
  }
}
