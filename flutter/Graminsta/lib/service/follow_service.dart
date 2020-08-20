import 'package:Graminsta/service/http_service.dart';

class FollowService {
  static FollowService _instance;

  factory FollowService() {
    _instance ??= FollowService._();
    return _instance;
  }

  FollowService._();

  static Future<bool> follow(int targetUserID) async {
    final res = await http.post("post/follow/", body: {
      "target_user": targetUserID,
    });
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}