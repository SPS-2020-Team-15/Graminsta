import 'package:flutter/material.dart';
import 'package:Graminsta/auth_service.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    AuthService.logIn(_usernameController.text, _passwordController.text,
        success: () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => route == null,
      );
    }, error: () {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('登录失败，请检查用户名和密码是否正确'),
          duration: Duration(milliseconds: 2000)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _loginForm(),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Login'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _login();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      width: 300,
      height: 120,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                  ),
                  hintText: "Username",
                ),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Flexible(
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
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
