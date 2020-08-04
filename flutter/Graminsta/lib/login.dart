import 'package:flutter/material.dart';

//登陆界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(20),
      child: new Column(
        children: <Widget>[
          LoginForm(),
          new MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: new Text('Login'),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget LoginForm() {
    return new Container(
      width: 300,
      height: 120,
      child: new Form(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: new TextFormField(
                decoration: new InputDecoration(
                  icon: new Icon(
                    Icons.email,
                  ),
                  hintText: "Email Address",
                ),
                style: new TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Flexible(
              child: new TextFormField(
                decoration: new InputDecoration(
                  icon: new Icon(
                    Icons.lock,
                  ),
                  hintText: "Password",
                ),
                obscureText: true,
                style: new TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
