import '../services/auth_service.dart';

class LoginViewModel {
  final AuthService _authService = AuthService();

  Future<String> autenticar({
    required String email,
    required String senha,
  }) async {
    return await _authService.login(
      email: email,
      senha: senha,
    );
  }
}