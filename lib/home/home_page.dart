import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maincopier/authentication/authentication.dart';
import 'package:maincopier/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = MyLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.welcomeToApp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: RaisedButton(
            child: Text(localizations.logout),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ),
      ),
    );
  }
}
