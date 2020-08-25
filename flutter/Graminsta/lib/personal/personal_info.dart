import 'package:Graminsta/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Graminsta/core/user_service.dart';
import 'package:Graminsta/custom_icons_icons.dart';
import 'package:Graminsta/spec/sizing.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _PersonalInfoState createState() => new _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  UserInfo _userInfo;

  Future<void> _getData() async {
    final info = await getUserInfo();
    _userInfo = info;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: Text(
                        _userInfo.user.username.substring(0, 1).toUpperCase(),
                        style: new TextStyle(
                            fontSize: PersonalInfoTitleFontSize,
                            fontWeight: FontWeight.w800),
                      ),
                      radius: 30.0,
                    ),
                    Container(
                      height: 60.0,
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                _userInfo.user.username,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontSize: PersonalInfoTitleFontSize,
                                    fontWeight: FontWeight.w800),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: new Border.all(
                                        color: Colors.blue, width: 0.5),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        CustomIcons.age,
                                        size: PersonalInfoFontSize,
                                      ),
                                      Text(
                                        _userInfo.age.toString(),
                                        textAlign: TextAlign.left,
                                        style: new TextStyle(
                                          fontSize: PersonalInfoFontSize,
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: new Border.all(
                                      color: Colors.blue, width: 0.5),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      CustomIcons.gender,
                                      size: PersonalInfoFontSize,
                                    ),
                                    Text(
                                      _userInfo.gender == 0 ? "M" : "F",
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: PersonalInfoFontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${_userInfo.user.firstName} ${_userInfo.user.lastName} | ${_userInfo.user.email}',
                            textAlign: TextAlign.left,
                            style:
                                new TextStyle(fontSize: PersonalInfoFontSize),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
