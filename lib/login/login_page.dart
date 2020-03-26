import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maincopier/authentication/authentication.dart';
import 'package:maincopier/l10n/l10n.dart';
import 'bloc/bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          },
          child: _LoginForm(),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  TextEditingController _usernameTextController;
  TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _usernameTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MyLocalizations.of(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure || state is LoginSuccess) {
          _usernameTextController.clear();
          _passwordTextController.clear();
        }
      },
      builder: (context, state) {
        if (state is LoginInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                localizations.welcomeToApp,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
            if (state is LoginFailure)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(localizations.authenticationFailure),
              ),
            TextField(
              controller: _usernameTextController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localizations.username,
              ),
            ),
            const Padding(padding: EdgeInsets.all(12)),
            TextField(
              controller: _passwordTextController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: localizations.password,
              ),
            ),
            const Padding(padding: EdgeInsets.all(12)),
            RaisedButton(
              child: Text(localizations.login),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(
                  username: _usernameTextController.text,
                  password: _passwordTextController.text,
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
