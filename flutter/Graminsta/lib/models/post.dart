/// A frontend model object that represents a Post.
class Post {
  final int id;
  final String description;
  final String img;
  final List markedUser;
  final List mentionUser;
  final String timeStamp;

  Post({this.id, this.description, this.img, this.markedUser, this.mentionUser, this.timeStamp});

  factory Post.fromJson(Map<String, Object> json) {
    return
      Post(
        id: json['id'],
        description: json['description'],
        img: json['img'],
        markedUser: json['markedUser'],
        mentionUser: json['mentionUser'],
        timeStamp: json['created_at']
      );
  }
}