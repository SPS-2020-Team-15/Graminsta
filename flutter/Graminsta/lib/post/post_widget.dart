import 'package:Graminsta/config.dart';
import 'package:Graminsta/models/post.dart';
import 'package:Graminsta/post/follow_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/post/mark_service.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isMarked = false;
  int _kudos = 0;
  bool _isFollowing = false;

  @override
  void initState() {
    _isMarked = widget.post.isMarked;
    _kudos = widget.post.kudos;
    _isFollowing = widget.post.isFollowing;
    super.initState();
  }

  void _removeMark(Post post) async {
    final result = await MarkService.removeMark(post);
    if (result == true) {
      setState(() {
        _isMarked = false;
        _kudos--;
      });
    }
  }

  void _addMark(Post post) async {
    final result = await MarkService.addMark(post);
    if (result == true) {
      setState(() {
        _isMarked = true;
        _kudos++;
      });
    }
  }

  void _unfollow(int id) async {
    final result = await UnfollowService.unfollow(id);
    if (result == true) {
      setState(() {
        _isFollowing = false;
      });
    }
  }

  void _follow(int id) async {
    final result = await FollowService.follow(id);
    if (result == true) {
      setState(() {
        _isFollowing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var markedUser = widget.post.markedUser.join(', ');
    if (markedUser.isNotEmpty) {
      markedUser += " liked";
    }
    var mentionUser = widget.post.mentionUser.join(' @');
    if (mentionUser.isNotEmpty) {
      mentionUser = " @$mentionUser";
    }

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
                Expanded(
                  child: SizedBox(),
                ),
                MaterialButton(
                  child: _isFollowing ? Text("Unfollow") : Text("Follow"),
                  onPressed: _isFollowing
                      ? () => _unfollow(widget.post.publisherId)
                      : () => _follow(widget.post.publisherId),
                )
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
                  onTap: _isMarked
                      ? () => _removeMark(widget.post)
                      : () => _addMark(widget.post),
                  child: _isMarked
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                  child: Tooltip(
                    preferBelow: false,
                    message: markedUser,
                    child: Text(
                      "$_kudos users liked",
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
