/// A frontend model object that represents a Post.
class Post {
  final int id;
  final String publisher;
  final String description;
  final String img;
  final List markedUser;
  final List mentionUser;
  final String timeStamp;
  bool isMarked;
  int kudos;

  Post({this.id, this.publisher, this.description, this.img, this.markedUser,
    this.mentionUser, this.timeStamp, this.isMarked, this.kudos});

  factory Post.fromJson(Map<String, Object> json) {
    return
      Post(
        id: json['id'],
        publisher: json['publisher_username'],
        description: json['description'],
        img: json['img'],
        markedUser: json['marked_username'],
        mentionUser: json['mention_username'],
        timeStamp: json['time_stamp'],
        isMarked: json['is_marked'],
        kudos: json['kudos']
      );
  }
}
