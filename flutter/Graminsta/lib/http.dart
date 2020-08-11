import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//A class to handle post and get request.
//Still working on it, trying to set the Authorization header.
class HttpManager {
  static Dio dio = Dio();
  static String baseUrl = "http://192.168.43.29:8000/"; // change into your base url

  static get(url, params) async {
    Response response;
    String requestUrl = baseUrl + url;
    try {
      response = await dio.get(requestUrl, queryParameters: params);
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
      response = await dio.post(requestUrl, data: params);
    } on DioError catch (e) {
      return e.response;
    }
    if (response.data is DioError) {
      return response.data;
    }
    return response;
  }
}
