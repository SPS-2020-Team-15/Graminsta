import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/service/follow_service.dart';
import 'package:Graminsta/models/user.dart';

Future<List<User>> fetchUsers() async{
  final response = await http.get("core/user/");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    debugPrint(response.body);
    return (responseJson as List)
        .map((p) => User.fromJson(p))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}

//TODO: use this function to initialize _followed
Future<Set<int>> fetchFollowingUsers(int id) async{
  final response = await http.get("post/user/" + id.toString() + '/');
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    debugPrint(response.body);
    return (responseJson as List)
        .map((p) => User.fromJson(p).id)
        .toSet();
  } else {
    throw Exception('Failed to load following people');
  }
}


class UsersListState extends State<UsersList> {

  List<User> _users = List<User>();
  Set<int> _followed = Set<int>();

  ListTile _buildItemsForListView(BuildContext context, int index) {
    final alreadyFollowed = _followed.contains(_users[index].id);
    return ListTile(
      title: Text(_users[index].username),
      subtitle: Text(_users[index].firstName + ' ' + _users[index].lastName),
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
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              _users = snapshot.data;
              return ListView.builder(
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
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Unable to follow'),
          duration: Duration(milliseconds: 2000)));
    }
  }
}

class UsersList extends StatefulWidget {
  @override
  createState() => UsersListState();
}