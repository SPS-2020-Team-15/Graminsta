import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/models/post.dart';
import 'package:Graminsta/core/user_service.dart';
import 'package:Graminsta/post/post_widget.dart';


class TimelineState extends State<TimelinePage> {
  List<Post> _posts = List<Post>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchTimeline(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            _posts = snapshot.data;
            return ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (BuildContext context, int index) {
                return PostWidget(_posts[index]);
              },
            );
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class TimelinePage extends StatefulWidget {
  @override
  createState() => TimelineState();
}
