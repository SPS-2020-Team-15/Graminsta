import 'package:Graminsta/config.dart';
import 'package:Graminsta/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/post/mark_service.dart';

Widget postWidget(Post post) {
  String markedUser = post.markedUser.join(', ');
  markedUser = markedUser == "" ? "" : markedUser + " liked";
  String mentionUser = post.mentionUser.join(' @');
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
                  post.publisher.substring(0, 1).toUpperCase(),
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
                      post.publisher,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      post.timeStamp,
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
          baseUrl + post.img,
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
          child: Row(
            children: <Widget>[
              GestureDetector(
                //Todo: refresh the widget after tap
                onTap: post.isMarked ? () => {MarkService.removeMark(post)}:
                    () => {MarkService.addMark(post)},
                child: post.isMarked ? Icon(Icons.favorite):Icon(Icons.favorite_border),
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
                        text: "${post.publisher}: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: post.description,
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
