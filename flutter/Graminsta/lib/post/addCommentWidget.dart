import 'package:Graminsta/service/http_service.dart';
import 'package:flutter/material.dart';

class AddCommentWidget extends StatefulWidget {
  AddCommentWidget({Key key}) : super(key: key);

  @override
  _AddCommentWidgetState createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String postId = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: AppBar(
        title: Text('Comment Post'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () async {
                final response = await http
                    .post("post/comment/", headers: <String, String>{}, body: {
                  "comment": myController.text,
                  "post_id": postId,
                });

                if (response.statusCode != 201) {
                  throw Exception('Failed to createPost');
                }

                Navigator.pop(context);
              })
        ],
      ),
      body: TextField(
        controller: myController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Add Your Comment",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
