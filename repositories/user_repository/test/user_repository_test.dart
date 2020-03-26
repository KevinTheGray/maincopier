import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  UserRepository userRepository;

  setUp(() {
    userRepository = FakeUserRepository();
  });

  group('User Repository', () {
    group('authenticate', () {
      test('returns a fake user', () async {
        final user = await userRepository.authenticate(
          username: 'vgv',
          password: 'unicorn',
        );
        expect(user, 'this_is_a_fake_user');
      });
    });

    group('isLoggedIn', () {
      test('returns false', () async {
        final result = await userRepository.isLoggedIn();
        expect(result, isFalse);
      });
    });
  });
}
