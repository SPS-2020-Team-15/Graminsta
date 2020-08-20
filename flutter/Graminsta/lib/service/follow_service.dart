import 'package:Graminsta/service/http_service.dart';
import 'dart:convert';

class FollowService {
  static FollowService _instance;

  factory FollowService() {
    _instance ??= FollowService._();
    return _instance;
  }

  FollowService._();

  static Future<bool> follow(int targetUserID) async {
    final response = await http.post("post/follow/",
        body: json.encode({
          "target_user": targetUserID,
        }));
    if (response.statusCode == 209) {
      return true;
    }
    return false;
  }
}