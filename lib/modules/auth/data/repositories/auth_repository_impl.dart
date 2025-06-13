import '../../domain/models/token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../storages/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._tokenStorage);

  @override
  Future<void> loginWithEmail(String email, String password) async {
    // Simulated backend login
    await Future.delayed(Duration(seconds: 1));
    await _tokenStorage.saveToken(
      Token(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      ),
    );
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
    await _tokenStorage.deleteToken();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getToken();
    return token != null;
  }

  @override
  Future<Token?> getToken() async {
    return await _tokenStorage.getToken();
  }

  @override
  Future<void> refreshToken() async {
    // Simulate token refresh
    await Future.delayed(Duration(milliseconds: 500));
    await _tokenStorage.saveToken(
      Token(
        accessToken: 'refreshed_access_token',
        refreshToken: 'refreshed_refresh_token',
      ),
    );
  }
}
