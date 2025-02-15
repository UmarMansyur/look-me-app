import 'package:look_me/network/api.dart';

class AuthApi {
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await Api.postRequest('auth/login-pegawai', {
      'email': email,
      'password': password,
    }, false);
    return response;
  }

  static Future<Map<String, dynamic>?> refreshToken(String refreshToken) async {
    final response = await Api.postRequest('auth/refresh-token', {
      'token_refresh': refreshToken,
    }, false);
    return response;
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final response = await Api.getRequest('auth/me', true);
    return response;
  }
}
