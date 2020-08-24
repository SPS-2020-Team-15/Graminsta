/// A frontend model object that represents a User.
class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.password});

  factory User.fromJson(Map<String, Object> json) {
    return User(
        id: json['id'],
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        password: json.containsKey('password') ? json['password'] : '');
  }

  Map<String, dynamic> toJson() => {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password
  };
}

class UserInfo {
  final User user;
  final int gender;
  final int age;

  UserInfo({this.user, this.gender, this.age});

  factory UserInfo.fromJson(Map<String, Object> json) {
    return UserInfo(
        user: User.fromJson(json['user']),
        gender: json['gender'],
        age: json['age']);
  }

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'gender': gender, 'age': age};
}
