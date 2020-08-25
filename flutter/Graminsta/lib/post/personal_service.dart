import 'dart:convert';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/post.dart';
import 'package:flutter/cupertino.dart';

Future<List<Post>> getAllPersonalPost() async {
  final res = await http.get("post/personal/");
  if (res.statusCode == 200) {
    final posts = jsonDecode(res.body);
    return (posts as List).map((p) => Post.fromJson(p)).toList();
  } else {
    throw Exception('Failed to load personal posts');
  }
}

Future<Map<Object, Object>> getPersonalCount() async {
  final res = await http.get("post/personal_count/");
  if (res.statusCode == 200) {
    final count = jsonDecode(res.body);
    return count;
  } else {
    throw Exception('Failed to load personal count');
  }
}
