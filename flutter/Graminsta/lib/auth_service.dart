import 'dart:convert';
import 'package:Graminsta/http_service.dart';

class AuthService {
  static AuthService _instance;

  factory AuthService() {
    _instance ??= AuthService._();
    return _instance;
  }

  AuthService._();

  static Future<bool> logIn(String username, String password) async {
    final res = await http.post("core/login/", body: {
      "username": username,
      "password": password,
    });
    if (res.statusCode == 200) {
      Map<String, Object> map = jsonDecode(res.body);
      final isTokenSet = await http.setAuthToken(map["token"]);
      if (isTokenSet) {
        return true;
      }
    }
    return false;
  }
}
