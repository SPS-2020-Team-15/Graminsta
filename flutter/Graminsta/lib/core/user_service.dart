import 'dart:async';
import 'dart:convert';
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
