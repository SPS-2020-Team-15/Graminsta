import 'dart:convert';
import 'package:Graminsta/services/webservice.dart';

class User {
  final String username;
  final String firstName;
  final String lastName;

  User({this.username, this.firstName, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return
      User(
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
      );
  }

  static Resource<List<User>> get all {
    return Resource(
        url: 'http://192.168.2.3:8000/core/user/',
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          return list.map((model) => User.fromJson(model)).toList();
        }
    );
  }
}
