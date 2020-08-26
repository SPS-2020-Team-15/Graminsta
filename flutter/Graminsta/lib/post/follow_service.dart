import 'package:Graminsta/service/http_service.dart';

class FollowService {
  static FollowService _instance;

  factory FollowService() {
    _instance ??= FollowService._();
    return _instance;
  }

  FollowService._();

  static Future<bool> follow(int targetUserID) async {
    final response = await http.post("post/follow/",
        body: {
          "target_user": targetUserID.toString(),
        },
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}

class UnfollowService {
  static UnfollowService _instance;

  factory UnfollowService() {
    _instance ??= UnfollowService._();
    return _instance;
  }

  UnfollowService._();

  static Future<bool> unfollow(int targetUserID) async {
    final response = await http.post("post/unfollow/",
        body: {
          "target_user": targetUserID.toString(),
        },
    );
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }
}