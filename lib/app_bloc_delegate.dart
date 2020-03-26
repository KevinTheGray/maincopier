import 'package:bloc/bloc.dart';
import 'package:lumberdash/lumberdash.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logMessage('${bloc.runtimeType}: $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logError(error, stacktrace: stacktrace);
  }
}
