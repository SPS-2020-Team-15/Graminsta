import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//A class to handle post and get request.
class HttpManager {
  static String baseUrl = "http://192.168.43.29:8000/";//change into your base url

  static void get(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('${key}=${value}&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }
    try {
      Response response;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
      //set options
      Dio dio = new Dio();
      dio.options.connectTimeout = 10000;
      dio.options.receiveTimeout = 3000;
      dio.options.headers.addAll(headersMap);
      //set request url
      url = baseUrl + url;
      //set Authorization header
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token') ?? '';
      if (token != "") {
        dio.options.headers["Authorization"] = "Token " + token;
      }
      //send get request
      response = await dio.get(url);
      //handle error
      if (response.statusCode != 200) {
        if (error != null) {
          error(response);
        }
        return;
      }
      //handle response data
      if (success != null) {
        success(response.data);
      }
    } catch (e) {
      if (error != null) {
        error(e);
      }
    }
  }

  static void post(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    try {
      Response response;
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
      print(dataMap);
      //set options
      Dio dio = new Dio();
      dio.options.connectTimeout = 10000;
      dio.options.receiveTimeout = 3000;
      dio.options.headers.addAll(headersMap);
      //set request url
      url = baseUrl + url;
      //set Authorization header
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token') ?? '';
      if (token != "") {
        dio.options.headers["Authorization"] = "Token " + token;
      }
      //send post request
      response = await dio.post(url, data: dataMap);
      //handle error
      if (response.statusCode != 200) {
        if (error != null) {
          error(response);
        }
        return;
      }
      //handle response data
      if (success != null) {
        success(response.data);
      }
    } catch (e) {
      if (error != null) {
        error(e);
      }
    }
  }
}
