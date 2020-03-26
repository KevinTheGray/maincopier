import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';

import 'package:maincopier/authentication/authentication.dart';
import 'package:maincopier/login/login.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: authenticationBloc,
    );
  });

  group('LoginBloc', () {
    test('initialState is LoginInitial', () {
      expect(loginBloc.initialState, LoginInitial());
    });

    group('LoginSubmitted', () {
      blocTest(
        'emits [LoginInProgress, LoginSuccess] when authenticate is OK',
        build: () async {
          when(userRepository.authenticate(
            username: 'vgv',
            password: 'secret',
          )).thenAnswer((_) => Future.value('user'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(
          const LoginSubmitted(
            username: 'vgv',
            password: 'secret',
          ),
        ),
        expect: [LoginInProgress(), LoginSuccess()],
      );

      blocTest(
        'emits [LoginInProgress, LoginFailure] when authenticate fails',
        build: () async {
          when(userRepository.authenticate(
            username: 'vgv',
            password: 'secret',
          )).thenThrow(Exception('oops'));
          return loginBloc;
        },
        act: (bloc) => bloc.add(
          const LoginSubmitted(
            username: 'vgv',
            password: 'secret',
          ),
        ),
        expect: [LoginInProgress(), LoginFailure()],
      );
    });
  });
}
