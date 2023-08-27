import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/core/helpers/is_non_russian_only.dart';
import 'package:worlds_away/features/common/presentation/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/common/presentation/widgets/my_error_widget.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_bloc.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_event.dart';
import 'package:worlds_away/features/user/profile/presentation/blocs/change/change_state.dart';
import 'package:worlds_away/features/user/profile/presentation/widgets/save_button.dart';

class ChangePageTemplate extends StatefulWidget {
  final String title;
  final String hintText;
  final int maxCharacterCount;
  final Function(String, ChangeBloc) onPressed;

  final bool isIdChange;

  const ChangePageTemplate({
    required this.title,
    required this.hintText,
    required this.onPressed,
    required this.maxCharacterCount,
    required this.isIdChange,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePageTemplate> createState() => _ChangePageTemplateState();
}

class _ChangePageTemplateState extends State<ChangePageTemplate> {
  final _formKey = GlobalKey<FormState>(); // Ключ для валидации формы
  final TextEditingController _changeController = TextEditingController();
  double _readyToChangeScale = 0;

  @override
  void dispose() {
    _changeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(42),
              ),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _changeController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(
                              widget.maxCharacterCount),
                        ],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (query) {
                          if (widget.isIdChange) {
                            _formKey.currentState!.validate();

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
                                if (idToSearch == "@" ||
                                    idToSearch.length <= 1) {
                                  _readyToChangeScale = 0;
                                } else {
                                  _readyToChangeScale = 1;
                                }
                              } else {
                                _readyToChangeScale = 0;
                              }
                            });
                          } else {
                            // reset state
                            BlocProvider.of<ChangeBloc>(context)
                                .add(ChangeInititState());

                            // set save button
                            setState(() {
                              if (query.trim().isNotEmpty) {
                                _readyToChangeScale = 1;
                              } else {
                                _readyToChangeScale = 0;
                              }
                            });
                          }
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
                        validator: (value) {
                          if (widget.isIdChange) {
                            if (!isNonRussianOnly(value!)) {
                              return 'Идентификатор не может иметь русских букв';
                            }
                          }

                          return null;
                        },
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
                  return const CupertinoLoading();
                }

                if (state is ChangeError) {
                  return MyErrorWidget(error: state.error!);
                }

                if (widget.isIdChange) {
                  if (state.idAvailableStatus == null ||
                      state.idAvailableStatus!) {
                    return AnimatedScale(
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
                    );
                  } else {
                    return const Text("ID занято");
                  }
                }

                return AnimatedScale(
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
                );
              },
            ),
          ],
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
    return SaveButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.onPressed(
                _changeController.text, BlocProvider.of<ChangeBloc>(context));
          }
        },
        title: "Сохранить");
  }
}
