import 'package:flutter_pluggable_modules/modules/common/result/result.dart';

import '../models/token.dart';

class AuthError {
  final String message;
  final String? code;

  AuthError(this.message, {this.code});
}

abstract class AuthRepository {
  Future<Result<Token, AuthError>> loginWithEmail(
    String email,
    String password,
  );
  Future<Result<void, AuthError>> logout();
  Future<Result<bool, AuthError>> isLoggedIn();
  Future<Result<Token, AuthError>> getToken();
  Future<Result<Token, AuthError>> refreshToken();
}
