import 'dart:convert';
import 'package:Graminsta/post/addCommentWidget.dart';
import 'package:Graminsta/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/models/post.dart';

class PostDetailsWidget extends StatefulWidget {
  PostDetailsWidget({Key key}) : super(key: key);

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetailsWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String postId = ModalRoute.of(context).settings.arguments.toString();

    return new Scaffold(
        appBar: AppBar(title: Text('Post Details'), actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCommentWidget(),
                  settings: RouteSettings(
                    arguments: postId,
                  ),
                ),
              );

              setState(() {});
            },
          )
        ]),
        body: FutureBuilder<List<String>>(
            future: Future.wait([
              getPostDetails(postId),
              getComments(postId),
            ]), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                String postDetails = snapshot.data[0];
                String comments = snapshot.data[1];
                final commentsJson = json.decode(comments);

                final post = Post.fromJson(json.decode(postDetails));

                List<Widget> widgets = [];
                widgets.add(PostWidget(post));

                for (int i = 0; i < commentsJson.length; ++i) {
                  String commentContent = commentsJson[i]["content"];
                  String username = '${commentsJson[i]["publisher"]["first_name"]} '
                      '${commentsJson[i]["publisher"]["last_name"]}: ';

                  widgets.add(
                    new ListTile(
                      leading: new Icon(Icons.comment),
                      title: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: username,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: commentContent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return new SingleChildScrollView(
                    child: new Column(children: widgets));
              } else {
                return new CircularProgressIndicator();
              }
            }));
  }
}

Future<String> getPostDetails(String postId) async {
  final response = await http.get(
    "post/" + postId,
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get all username');
  }
}

Future<String> getComments(String postId) async {
  final response = await http.get("post/comment/" + postId);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to get all username');
  }
}
