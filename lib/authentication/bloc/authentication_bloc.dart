import 'dart:async';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final isLoggedIn = await _userRepository.isLoggedIn();
      yield isLoggedIn ? AuthenticationSuccess() : AuthenticationFailure();
    }
    if (event is LoggedIn) {
      yield AuthenticationSuccess();
    }

    if (event is LoggedOut) {
      yield AuthenticationInProgress();
      await _userRepository.logout();
      yield AuthenticationFailure();
    }
  }
}
