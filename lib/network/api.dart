import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:look_me/store/token.dart';
class Api {
  static final Api _instance = Api._internal();
  static const String _baseUrl = 'http://192.168.1.89:3000';

  factory Api() => _instance;

  Api._internal();

  static Future<Map<String, dynamic>?> handleRequest(
    String path,
    String method,
    Map<String, dynamic>? body,
    bool isAuth,
  ) async {
    http.Response? response;
    try {
      
      final headers = {
        'Content-Type': 'application/json',
      };

      if(isAuth) {
        if(await TokenStore.isTokenExpired('access_token')) {
          await TokenStore.refreshToken();
        }
        headers['Authorization'] = 'Bearer ${await TokenStore.getTokenAccess()}';
      }

      final uri = Uri.parse('$_baseUrl/$path');

      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: headers,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: headers,
            body: body != null ? json.encode(body) : null,
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        case 'PATCH':
          response = await http.patch(
            uri,
            headers: headers,
            body: body != null ? json.encode(body) : null,
          );
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return json.decode(response.body);
    } catch (e) {
      print('API ERROR: $e');

      return {
        'status': false,
        'message': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>?> getRequest(
    String path,
    bool isAuth,
  ) async {
    return handleRequest(path, 'GET', null, isAuth);
  }

  static Future<Map<String, dynamic>?> postRequest(
    String path,
    Map<String, dynamic> body,
    bool isAuth,
  ) async {
    return handleRequest(path, 'POST', body, isAuth);
  }

  static Future<Map<String, dynamic>?> putRequest(
    String path,
    Map<String, dynamic> body,
    bool isAuth,
  ) async {
    return handleRequest(path, 'PUT', body, isAuth);
  }

  static Future<Map<String, dynamic>?> deleteRequest(
    String path,
    bool isAuth,
  ) async {
    return handleRequest(path, 'DELETE', null, isAuth);
  }

  static Future<Map<String, dynamic>?> patchRequest(
    String path,
    Map<String, dynamic> body,
    bool isAuth,
  ) async {
    return handleRequest(path, 'PATCH', body, isAuth);
  }
}