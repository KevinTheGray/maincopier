# maincopier

A new Flutter project created by the [Very Good Ventures Team](https://verygood.ventures/).

## How to run this project

This project has the following flavors:

 - production: `flutter run --flavor production`
 - development: `flutter run --flavor development`
 - qa: `flutter run --flavor qa`
 - qa2: `flutter run --flavor qa2`


## Working with translations

The official Flutter documentation can be found [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization).

In order to translate your application to different languages, this project relies on two packages, registered in the `pubspec.yaml`:

- `flutter_localizations`: it adds support for multiple languages, plus internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
- `intl_translation`: This package provides message extraction and code generation from translated messages for the `Intl` and/or `flutter_localizations` package.

### Generating an ARB to give to translators

Run this command from your terminal:

```bash
$> flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/localizations.dart
```

### Extracting ARB messages into Dart strings

Run this command from your terminal:

```bash
$> flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localizations.dart lib/l10n/intl_*.arb
```

### How to add new supported languages

#### Changes on the Flutter side

Add your new supported to locate to `lib/l10n/supported_locales.dart`.

#### For Android

You don't have to do anything!

#### For iOS

You will need to update the iOS App Bundle. More info [here](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#appendix-updating-the-ios-app-bundle)
