/// A frontend model object that represents a User.
class ListUser {
  final int id;
  final String firstName;
  final String lastName;
  bool isFollowing;

  ListUser({this.id, this.firstName,
    this.lastName, this.isFollowing,});

  factory ListUser.fromJson(Map<String, Object> json) {
    return
      ListUser(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        isFollowing: json['is_following'],
      );
  }
}
