import 'package:flutter/material.dart';
import 'package:Graminsta/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Graminsta",
      initialRoute: '/home',
      routes: {
        '/auth': (context) => AuthPage(),
        '/home': (context) => HomePage(),
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
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ), //change this into the timeline page.
    Text(
      'Index 2: Person',
      style: optionStyle,
    ), //change this into the gallery page.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    if (result) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (route) => route == null,
      );
    }
  }

  get _drawer => Drawer(
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
      );

  getIsLogin() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token') ?? '';
    debugPrint('user_token: $token');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    getIsLogin().then((token)=> {
      if(token == ""){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPage(),maintainState: false))
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graminsta'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      endDrawer: _drawer,
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
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
