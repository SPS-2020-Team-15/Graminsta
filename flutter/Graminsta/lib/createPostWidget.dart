import 'package:flutter/material.dart';

enum AccessControlType {
  public,
  private,
  visibleToSpecificFriends,
  invisibleToSpecificFriends,
}

extension AccessControlTypeExtension on AccessControlType {
  String toHumanReadableString() {
    switch (this) {
      case AccessControlType.public:
        return "All";
      case AccessControlType.private:
        return "Private";
      case AccessControlType.visibleToSpecificFriends:
        return "Visible to specfic friends";
      case AccessControlType.invisibleToSpecificFriends:
        return "Invisible to specfic friends";
      default:
        return null;
    }
  }
}

class CreatePostWidget extends StatefulWidget {
  CreatePostWidget({Key key}) : super(key: key);

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  AccessControlType accessControl = AccessControlType.public;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new Scaffold(
      appBar: AppBar(
        title: Text('Create a Post'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.only(bottom: 40.0),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Describe your post",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: width / 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: width / 4,
                width: width / 4,
                color: Color.fromRGBO(220, 220, 220, 0.8),
                child: Icon(Icons.add_a_photo),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 10),
            child: new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text("Location"),
                  trailing: Icon(Icons.arrow_right, size: 30),
                ),
                new ListTile(
                  leading: const Icon(Icons.alternate_email),
                  title: Text("Mention"),
                  trailing: Icon(Icons.arrow_right, size: 30),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("Share With"),
                  trailing: DropdownButton<AccessControlType>(
                    value: accessControl,
                    icon: Icon(Icons.arrow_downward),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (AccessControlType newValue) {
                      setState(() {
                        accessControl = newValue;
                      });
                    },
                    items: <AccessControlType>[
                      AccessControlType.public,
                      AccessControlType.private,
                      AccessControlType.visibleToSpecificFriends,
                      AccessControlType.invisibleToSpecificFriends
                    ].map<DropdownMenuItem<AccessControlType>>(
                        (AccessControlType accessControlType) {
                      return DropdownMenuItem<AccessControlType>(
                        value: accessControlType,
                        child: Text(accessControlType.toHumanReadableString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
