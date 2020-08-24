/// A frontend model object that represents UserInfo.
import 'package:Graminsta/models/user.dart';


class UserInfo {
  final User user;
  final int age;
  final int gender;


  UserInfo({this.user, this.age, this.gender});

  factory UserInfo.fromJson(Map<String, Object> json) {
    return
      UserInfo(
        user: User.fromJson(json['user']),
        age: json['age'],
        gender: json['gender'],
      );
  }
}
