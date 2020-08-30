import 'package:Graminsta/config.dart';
import 'package:Graminsta/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    String markedUser = widget.post.markedUser.join(', ');
    markedUser = markedUser == "" ? "" : markedUser + " liked";
    String mentionUser = widget.post.mentionUser.join(' @');
    mentionUser = mentionUser == "" ? "" : " @" + mentionUser;

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: Text(
                    widget.post.publisher.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  radius: 18.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.post.publisher,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.post.timeStamp,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.network(
            baseUrl + widget.post.img,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  //Todo: add mark
                  onTap: () {},
                  child: Icon(Icons.favorite_border),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: GestureDetector(
                    //Todo: show marked userList
                    onTap: () {},
                    child: Text(
                      markedUser,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  //Todo: add Comment
                  onTap: () {},
                  child: Icon(Icons.comment),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 6, 10, 10),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "${widget.post.publisher}: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: widget.post.description,
                        ),
                        TextSpan(
                          text: mentionUser,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 20,
          ),
        ],
      ),
    );
  }
}
