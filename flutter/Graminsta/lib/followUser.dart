import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:Graminsta/services/webservice.dart';
import 'package:Graminsta/models/user.dart';

class UsersListState extends State<UsersList> {

  List<User> _users = List<User>();
  final _saved = Set<String>();

  @override
  void initState() {
    super.initState();
    _populateUsers();
  }

  void _populateUsers() {

    Webservice().load(User.all).then((newsArticles) => {
      setState(() => {
        _users = newsArticles
      })
    });

  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    final alreadyFollowed = _saved.contains(_users[index].username);
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
        body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: _buildItemsForListView,
        ),
    );
  }

  void _createFollow(int index){
    _saved.add(_users[index].username);
    //send post to URL
    //to be completed after auth service is merged
    
  }

}

class UsersList extends StatefulWidget {
  @override
  createState() => UsersListState();
}