import 'dart:async';
import 'dart:convert';
import 'package:Graminsta/models/user.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/list_user.dart';
import 'package:flutter/cupertino.dart';

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
    debugPrint(response.body);
    return UserInfo.fromJson(responseJson);
  } else {
    throw Exception('Failed to load user info');
  }
}


///A function that returns a set of users that the given user follows
///TODO: use this function to initialize _followed
Future<Set<int>> fetchFollowingUsers(int id) async {
  final response = await http.get("post/user/" + id.toString() + '/');
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    debugPrint(response.body);
    return (responseJson as List)
        .map((p) => User.fromJson(p).id)
        .toSet();
  } else {
    throw Exception('Failed to load following people');
  }
}