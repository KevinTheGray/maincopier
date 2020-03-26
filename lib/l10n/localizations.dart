import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:maincopier/l10n/messages_all.dart';

// Localization is done using the Dart intl tools. With the
// app's root directory (the one that contains pubspec.yaml) as the current
// directory:
//
// flutter pub get
// flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/localizations.dart
// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localizations.dart lib/l10n/intl_*.arb
//
// The second command generates intl_messages.arb and the third generates
// messages_all.dart. There's more about this process in
// https://pub.dev/packages/intl.

class MyLocalizations {
  const MyLocalizations();

  static Future<MyLocalizations> load(Locale locale) {
    final name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = locale.toString();
    return initializeMessages(localeName).then((_) => const MyLocalizations());
  }

  static MyLocalizations of(BuildContext context) =>
      Localizations.of<MyLocalizations>(context, MyLocalizations);

  String get authenticationFailure {
    return Intl.message(
      'Authentication failure',
      name: 'authenticationFailure',
      desc: 'Message shown when there is an error at login',
    );
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Label for logging in users',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Label for logging out users',
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password label on login form',
    );
  }

  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: 'Username label on login form',
    );
  }

  String get welcomeToApp {
    return Intl.message(
      'Welcome to maincopier',
      name: 'welcomeToApp',
      desc: 'Label to welcome users to the app',
    );
  }
}
