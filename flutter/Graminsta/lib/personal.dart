import 'package:Graminsta/personal_gallery.dart';
import 'package:flutter/material.dart';
import 'package:Graminsta/personal_info.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => new _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          PersonalInfo(),
          PersonalGallery(),
        ],
      ),
    );
  }
}
