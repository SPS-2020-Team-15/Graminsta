import 'dart:convert';
import 'package:Graminsta/service/http_service.dart';

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

  static Future<dynamic> signUp(dynamic userInfo) async {
    final headers = {'Content-Type': 'application/json'};
    final res = await http.post("core/user/",
        headers: headers, body: json.encode(userInfo));
    dynamic mess = json.decode(res.body);
    if (res.statusCode == 201) {
      mess["status"] = "success";
    } else {
      mess["status"] = "fail";
    }
    return mess;
  }
}
