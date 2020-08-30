import 'dart:convert';
import 'package:Graminsta/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baseHttp;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graminsta/constants.dart';
import 'package:dio/dio.dart';

// Class that handles HTTP requests.
class _HttpService {
  static _HttpService _instance;

  var _globalHeaders = Map<String, String>();

  factory _HttpService() {
    _instance ??= _HttpService._();
    return _instance;
  }

  _HttpService._();

  // Set the auth token for authentication.
  Future<bool> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final setTokenResult = await prefs.setString(userTokenKey, token);
    if (setTokenResult) {
      _globalHeaders["Authorization"] = "Token " + token;
      return true;
    }
    return false;
  }

  Future<bool> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    if (result) {
      _globalHeaders.clear();
      return true;
    }
    return false;
  }

  Future<baseHttp.Response> get(
    String url, {
    Map<String, String> headers,
  }) async {
    baseHttp.Response response;
    headers ??= <String, String>{};
    headers.addAll(_globalHeaders);
    try {
      response = await baseHttp.get("$baseUrl$url", headers: headers);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  Future<baseHttp.Response> post(
    String url, {
    Map<String, String> headers,
    Object body = const {},
    Encoding encoding,
  }) async {
    baseHttp.Response response;
    headers ??= <String, String>{};
    headers.addAll(_globalHeaders);
    try {
      response = await baseHttp.post(
        "$baseUrl$url",
        headers: headers,
        body: body,
        encoding: encoding ??= Utf8Codec(),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  Future<Response> postForm(String url, FormData form) async {
    final dio = new Dio();
    Map<String, String> headers = {};
    headers.addAll(_globalHeaders);
    Response response;

    try {
      response = await dio.post(
        url,
        data: form,
        options: Options(contentType: 'multipart/form-data', headers: headers),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }
}

// Variable to allow other services to use _HttpService easily.
final http = _HttpService();
