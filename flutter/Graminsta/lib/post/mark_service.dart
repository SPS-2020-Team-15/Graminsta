import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/post.dart';

class MarkService {
  static MarkService _instance;

  factory MarkService() {
    _instance ??= MarkService._();
    return _instance;
  }

  MarkService._();

  static Future<bool> addMark(Post post) async {
    final response = await http.post("post/add-mark/",
      body: {
        "post_id": '${post.id}',
      },
    );
    if (response.statusCode == 201) {
      post.isMarked = true;
      return true;
    }
    return false;
  }

  static Future<bool> removeMark(Post post) async {
    final response = await http.post("post/remove-mark/",
      body: {
        "post_id": '${post.id}',
      },
    );
    if (response.statusCode == 201) {
      post.isMarked = false;
      return true;
    }
    return false;
  }
}
