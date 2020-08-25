import 'package:Graminsta/config.dart';
import 'package:Graminsta/models/post.dart';
import 'package:flutter/material.dart';

Widget postWidget(Post post) {
  return new Container(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(6, 0, 6, 4),
          child: Row(
            children: <Widget>[
              //Todo: get Username
              CircleAvatar(),
              Text(""),
            ],
          ),
        ),
        Image.network(
          baseUrl + post.img,
          fit: BoxFit.cover,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.favorite_border),
              Text(""),
              Container(
                child: Icon(Icons.comment),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Text(post.description),
            ],
          ),
        ),
        Divider(
          height: 12,
        ),
      ],
    ),
  );
}
