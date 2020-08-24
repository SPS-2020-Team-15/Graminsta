import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/user.dart';

///A function that returns a list of all the users.
Future<List<User>> fetchUsers() async {
  final followResponse = await http.get("post/follow/");
  Set<int> followingPeople;
  if (followResponse.statusCode == 200) {
    var responseJson = json.decode(followResponse.body);
    followingPeople = (responseJson as List)
        .map<int>((p) => p['id'])
        .toSet();
  } else {
    throw Exception('Failed to load following people');
  }

  final response = await http.get("core/user/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    return (responseJson as List)
        .map((p) => User.fromJson(p, followingPeople))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}
