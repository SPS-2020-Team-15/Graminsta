import 'dart:async';
import 'dart:convert';
import 'package:Graminsta/models/user.dart';
import 'package:Graminsta/models/post.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/list_user.dart';

///A function that returns a list of all the users.
Future<List<ListUser>> fetchUsers() async {
  final response = await http.get("post/users/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((p) => ListUser.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}

Future<UserInfo> getUserInfo() async {
  final response = await http.get("core/info/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return UserInfo.fromJson(responseJson);
  } else {
    throw Exception('Failed to load user info');
  }
}


///A function that returns a set of users that the given user follows
Future<List<ListUser>> fetchFollowingUsers() async {
  final response = await http.get("post/follow/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((p) => ListUser.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load following people');
  }
}

Future<List<ListUser>> fetchFollowers() async {
  final response = await http.get("post/follower/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((p) => ListUser.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load following people');
  }
}

Future<List<Post>> fetchTimeline() async {
  final response = await http.get("post/timeline/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((p) => Post.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load timeline posts');
  }
}