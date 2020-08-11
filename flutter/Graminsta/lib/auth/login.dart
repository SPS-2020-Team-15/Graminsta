import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Graminsta/http.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final form = {
      "username": _usernameController.text,
      "password": _passwordController.text,
    };
    Response response;
    try {
      response =
          await Dio().post("http://192.168.43.29:8000/core/login/", data: form);
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('登录失败，请检查用户名和密码是否正确'),
          duration: Duration(milliseconds: 2000)));
      return print(e);
    }
    if (response.statusCode == 200) {
      var token = response.data;
      final prefs = await SharedPreferences.getInstance();
      final setTokenResult = await prefs.setString('user_token', token);
      HttpManager.setHeader();
      if (setTokenResult) {
        //if set token success, redirect to homepage
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => route == null,
        );
      } else {
        debugPrint('保存登录token失败');
      }
    }
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
              login();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                controller: _usernameController,
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
