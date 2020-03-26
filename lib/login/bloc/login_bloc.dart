import 'dart:async';

import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:maincopier/authentication/authentication.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    @required AuthenticationBloc authenticationBloc,
    @required UserRepository userRepository,
  })  : assert(authenticationBloc != null),
        assert(userRepository != null),
        _authenticationBloc = authenticationBloc,
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event);
    }
  }

  Stream<LoginState> _mapLoginSubmittedToState(LoginSubmitted event) async* {
    yield LoginInProgress();
    try {
      final user = await _userRepository.authenticate(
        username: event.username,
        password: event.password,
      );
      _authenticationBloc.add(LoggedIn(user: user));
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailure();
    }
  }
}
