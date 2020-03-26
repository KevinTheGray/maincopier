import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user_repository/user_repository.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:print_lumberdash/print_lumberdash.dart';
import 'package:maincopier/app_bloc_delegate.dart';
import 'package:maincopier/authentication/bloc/bloc.dart';
import 'package:maincopier/home/home.dart';
import 'package:maincopier/l10n/l10n.dart';
import 'package:maincopier/login/login.dart';
import 'package:maincopier/splash/splash_page.dart';

void main() {
  putLumberdashToWork(withClients: [PrintLumberdash()]);
  BlocSupervisor.delegate = AppBlocDelegate();
  final userRepository = FakeUserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: RepositoryProvider<UserRepository>.value(
        value: userRepository,
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'maincopier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return HomePage();
          }
          if (state is AuthenticationFailure) {
            return LoginPage();
          }
          if (state is AuthenticationInProgress) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return SplashPage();
        },
      ),
    );
  }
}
