import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/models/user.dart';
import 'package:Graminsta/post/follow_service.dart';
import 'package:Graminsta/post/user_service.dart';


class UsersListState extends State<UsersList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<User> _users = List<User>();
  Set<int> _followed = Set<int>();

  ListTile _buildItemsForListView(BuildContext context, int index) {
    final alreadyFollowed = _followed.contains(_users[index].id);
    return ListTile(
      title: Text(_users[index].username),
      subtitle: Text('${_users[index].firstName} ${_users[index].lastName}'),
      trailing: FlatButton.icon(
        icon: Icon(Icons.add),
        label: Text('Follow'),
        onPressed: alreadyFollowed ? null :() => {_createFollow(index)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Users'),
        ),
        body: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
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
    _followed.add(_users[index].id);

    final followed = await FollowService.follow(_users[index].id);
    if (followed) {
      setState(() {});//refresh the current page
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Unable to follow'),
          duration: Duration(milliseconds: 2000)));
    }
  }
}

class UsersList extends StatefulWidget {
  @override
  createState() => UsersListState();
}