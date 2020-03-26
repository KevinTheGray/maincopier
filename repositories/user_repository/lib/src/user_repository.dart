import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  });

  Future<void> logout();

  Future<bool> isLoggedIn();
}

class FakeUserRepository extends UserRepository {
  @override
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) {
    // this is a fake implementation, just to showcase the feature
    return Future.delayed(
      const Duration(seconds: 1),
      () => 'this_is_a_fake_user',
    );
  }

  @override
  Future<void> logout() => Future.delayed(const Duration(milliseconds: 500));

  @override
  Future<bool> isLoggedIn() => Future.delayed(
        const Duration(milliseconds: 250),
        () => false,
      );
}
