import 'package:Graminsta/config.dart';
import 'package:Graminsta/post/post_widget.dart';
import 'package:Graminsta/spec/sizing.dart';
import 'package:Graminsta/spec/spacing.dart';
import 'package:flutter/material.dart';
import 'package:Graminsta/post/personal_service.dart';
import 'package:Graminsta/constants.dart';
import 'package:Graminsta/personal/personal_follow.dart';

class PersonalGallery extends StatefulWidget {
  @override
  _PersonalGalleryState createState() => new _PersonalGalleryState();
}

class _PersonalGalleryState extends State<PersonalGallery> {

  Future<Map<String, Object>> _getData() async {
    final list = await getPersonalGallery();
    return list;
  }


  _showFollowing() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
     FollowingList(option: "following",)));
  }

  _showFans() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        FollowingList(option: "follower",)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, Object>> snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              snapshot.data[postCountKey].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: PersonalInfoTitleFontSize,
                              ),
                            ),
                            Text(
                              "Posts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: PersonalInfoFontSize,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            _showFollowing();
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                snapshot.data[followingCountKey].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: PersonalInfoTitleFontSize,
                                ),
                              ),
                              Text(
                                "Following",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: PersonalInfoFontSize,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            _showFans();
                          },
                          child: Column(
                            children: <Widget>[
                              Text(
                                snapshot.data[fanCountKey].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: PersonalInfoTitleFontSize,
                                ),
                              ),
                              Text(
                                "Fans",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: PersonalInfoFontSize,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                  ),
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
                      _gridView(snapshot.data["posts"]),
                      _listView(snapshot.data["posts"]),
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
      padding: EdgeInsets.all(personalGalleryImgPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: personalGalleryImgPadding,
        mainAxisSpacing: personalGalleryImgPadding,
      ),
      children: postList
          .map((item) => Image.network(
                baseUrl + item.img,
                fit: BoxFit.cover,
              ))
          .toList(),
    );
  }

  Widget _listView(List postList) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return PostWidget(postList[index]);
      },
      itemCount: postList.length,
    );
  }
}
