import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/models/list_user.dart';
import 'package:Graminsta/post/follow_service.dart';
import 'package:Graminsta/core/user_service.dart';


class UsersListState extends State<UsersList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ListUser> _users = List<ListUser>();

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text('${_users[index].firstName} ${_users[index].lastName}'),
      trailing: _users[index].isFollowing ?
      FlatButton.icon(
        icon: Icon(Icons.delete),
        label: Text('Unfollow'),
        onPressed: () => {_deleteFollow(index)},
      ):
      FlatButton.icon(
        icon: Icon(Icons.add),
        label: Text('Follow'),
        onPressed: () => {_createFollow(index)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: FutureBuilder(
          future: fetchUsers(),
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

  void _createFollow (int index) async{
    _users[index].isFollowing = true;

    final followed = await FollowService.follow(_users[index].id);
    if (followed) {
      setState(() {});//refresh the current page
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Unable to follow'),
          duration: Duration(milliseconds: 2000)));
    }
  }

  void _deleteFollow (int index) async{
    _users[index].isFollowing = false;

    final unfollowed = await UnfollowService.unfollow(_users[index].id);
    if (unfollowed) {
      setState(() {});//refresh the current page
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Unable to unfollow'),
          duration: Duration(milliseconds: 2000)));
    }
  }

}

class UsersList extends StatefulWidget {
  @override
  createState() => UsersListState();
}