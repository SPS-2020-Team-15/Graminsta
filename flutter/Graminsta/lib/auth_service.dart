import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Graminsta/http_service.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static AuthService _instance;

  factory AuthService() {
    _instance ??= AuthService._();
    return _instance;
  }

  AuthService._();

  static Future<void> logIn(String username, String password,
      {Function success, Function error}) {
    http.post("core/login/",
        body: {"username": username, "password": password}).then((res) {
      if (res.statusCode == 200) {
        Map<String, Object> map = jsonDecode(res.body);
        http.setAuthToken(map["token"], success: success);
      } else {
        error();
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
