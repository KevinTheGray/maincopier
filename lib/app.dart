import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:user_repository/user_repository.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:print_lumberdash/print_lumberdash.dart';
import 'package:maincopier/app_bloc_delegate.dart';
import 'package:maincopier/authentication/bloc/bloc.dart';
import 'package:maincopier/l10n/l10n.dart';

Future<void> runMainCopierApp(String flavor) async {
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
        child: App(
          flavor: flavor,
        ),
      ),
    ),
  );
}

class App extends StatelessWidget {
  final String flavor;

  const App({Key key, this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: flavor,
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
      home: Scaffold(
        body: Center(child: Text(flavor)),
      ),
    );
  }
}
