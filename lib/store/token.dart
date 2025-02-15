import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:look_me/network/api/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String> getTokenAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final token = json.decode(prefs.getString('token') ?? '');
    return token['access_token'] ?? '';
  }

  static Future<String> getTokenRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final token = json.decode(prefs.getString('token') ?? '');
    return token['refresh_token'] ?? '';
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // check expired token
  static Future<bool> isTokenExpired(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final token = json.decode(prefs.getString('token') ?? '');
    return JwtDecoder.isExpired(token[type] ?? '');
  }

  static Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = json.decode(prefs.getString('token') ?? '');

    if(await isTokenExpired('access_token')) {
      await deleteToken();
      return;
    }

    final response = await AuthApi.refreshToken(token['refresh_token'] ?? '');
    if(response?['status'] == true) {
      await saveToken(json.encode(response?['data']));
    }
  }

  static Future<Map<String, dynamic>?> decodeToken() async {
    if(await isTokenExpired('access_token')) {
      await deleteToken();
    }

    final response = await AuthApi.getUser();
    return response;
  }
}