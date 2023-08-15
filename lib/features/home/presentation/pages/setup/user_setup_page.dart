import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/core/constants/constants.dart';
import 'package:worlds_away/core/helpers/is_latin_only.dart';
import 'package:worlds_away/core/widgets/cupertino_loading.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/setup_page/setup_page_bloc.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/setup_page/setup_page_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/setup/setup_page/setup_page_state.dart';
import 'package:worlds_away/features/home/presentation/widgets/setup_error_widget.dart';

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({super.key});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  @override
  void initState() {
    BlocProvider.of<SetupPageBloc>(context).add(GetSetupPageInformation());
    super.initState();
  }

  final _formKey = GlobalKey<FormState>(); // Ключ для валидации формы
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarWidget(),
      body: _buildBody(),
    );
  }

  _buildAppBarWidget() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Настройка Профиля"),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<SetupPageBloc, SetupPageState>(
      builder: (context, state) {
        if (state is SetupPageLoading) {
          return const CupertinoLoading();
        }

        if (state is SetupPageError) {
          return SetupErrorWidget(error: state.error!);
        }

        if (state is SetupPageDone) {
          final String? email = state.user!.email;
          final String? uniqueUid = state.user!.uniqueUid;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Имя',
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.trim().isNotEmpty) {
                          return 'Имя обязательно';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _idController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'ID',
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ID обязателен';
                        }

                        if (value.contains(" ")) {
                          return 'ID не может иметь пробелов';
                        }

                        if (!isLatinOnly(value)) {
                          return 'ID может иметь только латинские буквы';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _aboutController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'О себе',
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Данные Аккаунта:',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Text('Email: $email'),
                    const SizedBox(height: 8),
                    Text('Уникальный ID: $uniqueUid'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String id = _idController.text.toLowerCase();

                          BlocProvider.of<SetupPageBloc>(context)
                              .add(CheckIdAvailable(id));
                        }
                      },
                      child: const Text(
                        'Готово',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    BlocBuilder<SetupPageBloc, SetupPageState>(
                      builder: (context, state) {
                        String name = _nameController.text.trim();
                        String id = _idController.text.toLowerCase();
                        String about = _aboutController.text.trim();

                        if (state.idIsAvailable == true) {
                          _onIdAvailableToSendInformationDone(
                              name: name, id: id, about: about);
                          return const CupertinoLoading();
                        } else if (state.idIsAvailable == false) {
                          return const Padding(
                            padding: EdgeInsets.only(left: 5, top: 10),
                            child: Text(
                              "ID занято",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is SetupPageSendInformationDone) {
          _onUserSetupSuccess();
        }

        return const SizedBox();
      },
    );
  }

  _onIdAvailableToSendInformationDone(
      {required String name, required String id, required String about}) {
    BlocProvider.of<SetupPageBloc>(context)
        .add(SendSetupInformation(name, id, about));
  }

  _onUserSetupSuccess() {
    Future.microtask(() =>
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _aboutController.dispose();
    super.dispose();
  }
}
