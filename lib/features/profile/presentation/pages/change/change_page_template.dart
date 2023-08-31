import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/shared/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/profile/presentation/blocs/change/change_bloc.dart';
import 'package:worlds_away/features/profile/presentation/blocs/change/change_event.dart';
import 'package:worlds_away/features/profile/presentation/blocs/change/change_state.dart';
import 'package:worlds_away/features/profile/presentation/widgets/save_button.dart';

class ChangePageTemplate extends StatefulWidget {
  final String title;
  final String labelText;
  final String helperText;
  final int maxCharacterCount;
  final Function(String, ChangeBloc) onPressed;

  final bool isIdChange;

  const ChangePageTemplate({
    required this.title,
    required this.labelText,
    required this.helperText,
    required this.onPressed,
    required this.maxCharacterCount,
    required this.isIdChange,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePageTemplate> createState() => _ChangePageTemplateState();
}

class _ChangePageTemplateState extends State<ChangePageTemplate> {
  final TextEditingController _changeController = TextEditingController();
  double _readyToChangeOpacity = 0;

  @override
  void dispose() {
    _changeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(42),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _changeController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          widget.maxCharacterCount),
                      if (widget.isIdChange)
                        FilteringTextInputFormatter.deny(
                            RegExp(r'[^a-zA-Z0-9]'))
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    onChanged: (query) {
                      if (widget.isIdChange) {
                        // id text to id view
                        String idToSearch = query.toLowerCase().trim();

                        if (idToSearch.isNotEmpty && idToSearch[0] != "@") {
                          idToSearch = "@$idToSearch";
                        }

                        // check id available
                        BlocProvider.of<ChangeBloc>(context)
                            .add(ChangeCheckIdAvailable(idToSearch));

                        // set save button
                        setState(() {
                          if (idToSearch.isNotEmpty) {
                            _readyToChangeOpacity = 1;
                          } else {
                            _readyToChangeOpacity = 0;
                          }
                        });
                      } else {
                        // reset state
                        BlocProvider.of<ChangeBloc>(context)
                            .add(ChangeInititState());

                        // set save button
                        setState(() {
                          if (query.trim().isNotEmpty) {
                            _readyToChangeOpacity = 1;
                          } else {
                            _readyToChangeOpacity = 0;
                          }
                        });
                      }
                    },
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefixText: (widget.isIdChange) ? "@" : null,
                      label: Text(widget.labelText),
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      prefixStyle:
                          const TextStyle(color: Colors.white, fontSize: 17),
                      prefixIcon: const Icon(Icons.edit),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "${_changeController.text.trim().length}/${widget.maxCharacterCount}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ChangeBloc, ChangeState>(
            builder: (context, state) {
              if (state is ChangeDone) {
                return const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Успешно!",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              if (state is ChangeLoading) {
                return const Padding(
                  padding: EdgeInsets.only(right: 65, top: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoLoading(
                      isCenter: false,
                    ),
                  ),
                );
              }

              if (state is ChangeError) {
                return MyErrorWidget(error: state.error!);
              }

              if (widget.isIdChange) {
                if (state.idAvailableStatus == null ||
                    state.idAvailableStatus!) {
                  return AnimatedOpacity(
                    opacity: _readyToChangeOpacity,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInSine,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 17),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: _buildSaveButton(),
                      ),
                    ),
                  );
                } else {
                  return const Text(
                    "ID занято",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
              }

              return AnimatedOpacity(
                opacity: _readyToChangeOpacity,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInSine,
                child: Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: _buildSaveButton(),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          Container(
            constraints: const BoxConstraints(maxHeight: 60),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.helperText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
    return SaveButton(
        onPressed: () => widget.onPressed(
            _changeController.text, BlocProvider.of<ChangeBloc>(context)),
        title: "Сохранить");
  }
}
