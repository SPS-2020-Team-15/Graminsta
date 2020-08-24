/// A frontend model object that represents a User.
class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;

  User({this.id, this.username, this.firstName, this.lastName});

  factory User.fromJson(Map<String, Object> json) {
    return
      User(
        id: json['id'],
        username: json['username'],
        firstName: json['first_name'],
        lastName: json['last_name'],
      );
  }
}