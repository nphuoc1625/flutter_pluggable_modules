import '../models/token.dart';

abstract class AuthRepository {
  Future<void> loginWithEmail(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<Token?> getToken();
  Future<void> refreshToken();
}
