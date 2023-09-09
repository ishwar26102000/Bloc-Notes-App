import 'package:basic_bloc_notes_app/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoginApiProtocall {
  const LoginApiProtocall();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}



@immutable
class LoginApi implements LoginApiProtocall {
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'ishwar@gmail.com' && password == '123456',
      ).then((isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null);
}
