import 'package:Graminsta/post/createPostWidget.dart';
import 'package:Graminsta/post/mentionUserWidget.dart';
import 'package:flutter/material.dart';
import 'package:Graminsta/auth/auth.dart';
import 'package:Graminsta/personal/personal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graminsta/service/http_service.dart';
import 'package:Graminsta/post/follow_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Graminsta",
      initialRoute: '/home',
      routes: {
        '/create': (context) => CreatePostWidget(),
        '/mention': (context) => MentionUserWidget(),
        '/auth': (context) => AuthPage(),
        '/home': (context) => HomePage(),
        '/users': (context) => UsersList(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ), //change this into the timeline page.
    PersonalPage(), 
    UsersList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    //clear SharedPreferences and redirect to AuthPage.
    final result = await http.clearAuthToken();
    if (result) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (route) => route == null,
      );
    }
  }

  Future<bool> _checkUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';
    if (token == "") {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (route) => route == null,
      );
      return false;
    }
    http.setAuthToken(token);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //check user login status. If there is no token, redirect to AuthPage.
    return FutureBuilder(
      future: _checkUserToken(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Graminsta'),
            ),
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            endDrawer: Drawer(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Logout'),
                    onTap: () {
                      _logout();
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Add()),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Person'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  title: Text('People'),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Center(
        child: Text("Add Post"), //change this into the create new post page.
      ),
    );
  }
}
