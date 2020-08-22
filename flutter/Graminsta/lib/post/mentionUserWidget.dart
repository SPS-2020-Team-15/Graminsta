import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MentionUserWidget extends StatefulWidget {
  MentionUserWidget({Key key}) : super(key: key);

  @override
  _MentionUserWidgetState createState() => _MentionUserWidgetState();
}

class _MentionUserWidgetState extends State<MentionUserWidget> {
  List<IconData> userIcons = new List();
  List<String> allNames;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Mention Users'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () async {
                  String mentionedUser = "";
                  for (int i = 0; i < allNames.length; ++i) {
                    if (userIcons[i] == Icons.check) {
                      if (mentionedUser.length > 0) {
                        mentionedUser += ",";
                      }
                      mentionedUser += allNames[i];
                    }
                  }

                  Navigator.pop(context, mentionedUser);
                })
          ],
        ),
        body: FutureBuilder<List<String>>(
            future:
                getUsername(), // a previously-obtained Future<String> or null
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                allNames = snapshot.data;

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                List<Widget> widgets = [];
                for (int i = 0; i < allNames.length; ++i) {
                  String name = allNames[i];
                  userIcons.add(Icons.panorama_fish_eye);

                  widgets.add(new ListTile(
                      title: Text(name),
                      trailing: IconButton(
                          icon: Icon(userIcons[i]),
                          onPressed: () {
                            setState(() {
                              if (userIcons[i] == Icons.panorama_fish_eye) {
                                userIcons[i] = Icons.check;
                              } else {
                                userIcons[i] = Icons.panorama_fish_eye;
                              }
                            });
                          })));
                }
                return new Column(children: widgets);
              } else {
                return new CircularProgressIndicator();
              }
            }));
  }

  Future<List<String>> getUsername() async {
    final http.Response response =
        await http.get("http://10.0.2.2:8000/core/user/");

    if (response.statusCode == 200) {
      // If the server did return a 200 request OK response,
      // then split the string
      return response.body.split(",");
    } else {
      // If the server did not return a 200 response,
      // then throw an exception.
      throw Exception('Failed to get all username');
    }
  }
}
