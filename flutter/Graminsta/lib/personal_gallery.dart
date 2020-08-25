import 'package:flutter/material.dart';
import 'package:Graminsta/post/personal_service.dart';

class PersonalGallery extends StatefulWidget {
  @override
  _PersonalGalleryState createState() => new _PersonalGalleryState();
}

class _PersonalGalleryState extends State<PersonalGallery> {
  Future<List> _getPosts() async {
    final list = await getAllPersonalPost();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPosts(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 1,
                    labelStyle: TextStyle(fontSize: 14),
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.list)),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(children: <Widget>[
                      _gridView(snapshot.data),
                      _listView(snapshot.data),
                    ]),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _gridView(List postList) {
    return GridView(
      padding: EdgeInsets.symmetric(vertical: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
//      children: postList
//      //Todo: show image
//          .map((item) => Image.asset(
//                item.img,
//                fit: BoxFit.cover,
//              ))
//          .toList(),
    );
  }

  Widget _listView(List postList) {
    //Todo: build ListView
    return Container();
  }
}
