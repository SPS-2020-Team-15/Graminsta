import 'dart:convert';
import 'package:Graminsta/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baseHttp;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graminsta/constants.dart';

// Class that handles HTTP requests.
class _HttpService {
  static _HttpService _instance;

  final globalHeaders = Map<String, String>();

  factory _HttpService() {
    _instance ??= _HttpService._();
    return _instance;
  }

  _HttpService._();

  // Set the auth token for authentication.
  Future<void> setAuthToken(String token, {Function success}) async {
    final prefs = await SharedPreferences.getInstance();
    final setTokenResult = await prefs.setString(userTokenKey, token);
    if (setTokenResult) {
      if (success != null) {
        success();
      }
    } else {
      debugPrint('保存登录token失败');
    }
  }

  Future<baseHttp.Response> get(String url,
      {Map<String, String> headers}) async {
    baseHttp.Response response;
    Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
    url = baseUrl + url;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(userTokenKey) ?? '';
    if (token != "") {
      headersMap.addAll({"token": token});
    }
    try {
      response = await get(url, headers: headersMap);
    } catch (e) {
      debugPrint(e);
    }
    return response;
  }

  Future<baseHttp.Response> post(String url,
      {Map<String, String> headers, Object body, Encoding encoding}) async {
    baseHttp.Response response;
    Map<String, String> headersMap = headers == null ? new Map() : headers;
    Map<String, String> dataMap = body == null ? new Map() : body;
    url = baseUrl + url;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(userTokenKey) ?? '';
    if (token != "") {
      headersMap.addAll({"token": token});
    }
    try {
      response = await baseHttp.post(url,
          headers: headersMap,
          body: dataMap,
          encoding: encoding ??= Utf8Codec());
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }
}

// Variable to allow other services to use _HttpService easily.
final http = _HttpService();
