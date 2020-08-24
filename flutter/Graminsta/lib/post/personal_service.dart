import 'dart:convert';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/post.dart';

class PersonalService {
  static PersonalService _instance;

  factory PersonalService() {
    _instance ??= PersonalService._();
    return _instance;
  }

  PersonalService._();

  static Future<List<Post>> getAllPersonalPost() async {
    final res = await http.get("post/personal/");
    if (res.statusCode == 200) {
      final posts = jsonDecode(res.body);
      return (posts as List).map((p) => Post.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load personal posts');
    }
  }
}
