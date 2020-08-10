import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _LoginForm(),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Login'),
          )
        ],
      ),
    );
  }

  Widget _LoginForm() {
    return Container(
      width: 300,
      height: 120,
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                  ),
                  hintText: "Email Address",
                ),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                  ),
                  hintText: "Password",
                ),
                obscureText: true,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
