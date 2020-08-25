import 'dart:convert';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/post.dart';

Future<Map<String, Object>> getPersonalGallery() async {
  final res = await http.get("post/personal/");
  if (res.statusCode == 200) {
    final posts = jsonDecode(res.body);
    posts["posts"] = (posts["posts"] as List).map((p) => Post.fromJson(p)).toList();
    return posts;
  } else {
    throw Exception('Failed to load personal posts');
  }
}

