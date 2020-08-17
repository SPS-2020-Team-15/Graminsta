import 'dart:convert';
import 'package:Graminsta/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as baseHttp;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graminsta/constants.dart';

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
    Map<String, String> headersMap = headers == null ? new Map() : headers;
    headersMap.addAll(_globalHeaders);
    try {
      response = await baseHttp.get("$baseUrl$url", headers: headersMap);
    } catch (e) {
      debugPrint(e.toString());
    }
    return response;
  }

  Future<baseHttp.Response> post(
    String url, {
    Map<String, String> headers,
    Object body,
    Encoding encoding,
  }) async {
    baseHttp.Response response;
    Map<String, String> headersMap = headers == null ? new Map() : headers;
    Map<String, String> dataMap = body == null ? new Map() : body;
    headersMap.addAll(_globalHeaders);
    try {
      response = await baseHttp.post("$baseUrl$url",
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
