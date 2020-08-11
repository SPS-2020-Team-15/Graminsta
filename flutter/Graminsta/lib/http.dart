import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//A class to handle post and get request.
class HttpManager {
  static Dio _dio = Dio();
  // change into your base url
  static String baseUrl = "http://192.168.43.29:8000/";


  static setHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';
    _dio.options.headers["Authorization"] = "Token " + token;
  }

  static get(url, params) async {
    Response response;
    String requestUrl = baseUrl + url;
    try {
      response = await _dio.get(requestUrl, queryParameters: params);
    } on DioError catch (e) {
      return e.response;
    }
    if (response.data is DioError) {
      return response.data;
    }
    return response;
  }

  static post(url, params) async {
    Response response;
    String requestUrl = baseUrl + url;
    try {
      response = await _dio.post(requestUrl, data: params);
    } on DioError catch (e) {
      return e.response;
    }
    if (response.data is DioError) {
      return response.data;
    }
    return response;
  }
}
