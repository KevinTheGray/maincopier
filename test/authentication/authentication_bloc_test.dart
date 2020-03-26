import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

import 'package:maincopier/authentication/authentication.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository userRepository;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
  });

  group('AuthenticationBloc', () {
    test('initial state is AuthenticationInitial', () {
      expect(authenticationBloc.initialState, AuthenticationInitial());
    });

    group('AppStarted', () {
      blocTest(
        'emits [AuthenticationFailure] when it is not logged in',
        build: () async {
          when(userRepository.isLoggedIn())
              .thenAnswer((_) => Future.value(false));
          return authenticationBloc;
        },
        act: (bloc) => bloc.add(AppStarted()),
        expect: [AuthenticationFailure()],
      );

      blocTest(
        'emits [AuthenticationSuccess] when it is logged in',
        build: () async {
          when(userRepository.isLoggedIn())
              .thenAnswer((_) => Future.value(true));
          return authenticationBloc;
        },
        act: (bloc) => bloc.add(AppStarted()),
        expect: [AuthenticationSuccess()],
      );
    });
  });

  group('LoggedIn', () {
    blocTest(
      'emits [AuthenticationSuccess] when logging in',
      build: () async => authenticationBloc,
      act: (bloc) => bloc.add(const LoggedIn(user: 'instance.user')),
      expect: [AuthenticationSuccess()],
    );
  });

  group('LoggedOut', () {
    blocTest(
      'emits [AuthenticationInProgress, AuthenticationFailure] when logging out',
      build: () async {
        when(userRepository.logout()).thenAnswer((_) => Future.value());
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LoggedOut()),
      expect: [
        AuthenticationInProgress(),
        AuthenticationFailure(),
      ],
    );
  });
}
