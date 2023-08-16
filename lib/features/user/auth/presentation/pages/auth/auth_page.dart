import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:worlds_away/features/common/presentation/widgets/auth_elevated_button.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/auth/auth_event.dart';
import 'package:worlds_away/features/user/auth/presentation/blocs/auth/auth_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
            child: Text(
          "Добро Пожаловать в Worlds Away!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        )),
        const SizedBox(
          height: 100,
        ),
        const Center(
          child: Image(
            image: AssetImage("assets/images/worlds_away_logo.png"),
            color: Colors.white,
            width: 165,
            height: 165,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(
                color: Colors.white,
              ));
            }

            if (state is UserSignOut || state is AuthError) {
              if (state.error != null) {
                _onError(context, state.error);
              }

              return Center(child: _buildSignInWithGoogleButton());
            }

            if (state is UserSignIn) {
              return const Center(
                  child: Text(
                "Успешно",
                style: TextStyle(
                  color: Colors.green,
                ),
              ));
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }

  _buildSignInWithGoogleButton() {
    return Builder(builder: (context) {
      return AuthElevatedButton(
          title: "Войти с Google", function: () => _onSignInPressed(context));
    });
  }

  _onError(context, error) {
    Future.microtask(() => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 0,
            showCloseIcon: true,
            closeIconColor: Colors.blue,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black,
            content: Text('Error: $error'),
          ),
        ));
  }

  _onSignInPressed(context) {
    BlocProvider.of<AuthBloc>(context).add(const SignIn());
  }
}
