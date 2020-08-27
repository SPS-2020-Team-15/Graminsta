import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/models/list_user.dart';
import 'package:Graminsta/core/user_service.dart';


class UsersListState extends State<FollowingList> {
  String option;
  UsersListState({this.option});

  List<ListUser> _users = List<ListUser>();

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text('${_users[index].firstName} ${_users[index].lastName}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: option == "following" ?
        const Text('Following People'):
        const Text('Followers'),
      ),
      body: FutureBuilder(
        future: option == "following" ?
          fetchFollowingUsers():fetchFollowers(),
        builder: (BuildContext context, AsyncSnapshot<List<ListUser>> snapshot) {
          if (snapshot.hasData) {
            _users = snapshot.data;
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: _users.length,
              itemBuilder: _buildItemsForListView,
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

class FollowingList extends StatefulWidget {
  final String option;
  FollowingList({this.option});

  @override
  createState() => UsersListState(option: option);
}