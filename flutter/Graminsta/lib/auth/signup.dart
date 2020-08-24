import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Graminsta/custom_icons_icons.dart';
import 'package:Graminsta/models/user.dart';
import 'package:Graminsta/service/auth_service.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  void _signup() async {
    String password1 = _passwordController.text;
    debugPrint(password1);
    String password2 = _passwordAgainController.text;
    debugPrint(password2);
    if (password1 != password2) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Two passwords are not same'),
          duration: Duration(milliseconds: 2000)));
      return;
    }

    User user = User.fromJson({
      'id': 0,
      'username': _usernameController.text,
      'first_name': _firstnameController.text,
      'last_name': _lastnameController.text,
      'email': _emailAddressController.text,
      'password': password1,
    });
    int gender = (_genderController.text == 'M') ? 0 : 1;
    int age = int.parse(_ageController.text);
    UserInfo userInfo = UserInfo(user: user, gender: gender, age: age);

    final mess = await AuthService.signUp(userInfo);
    if (mess["status"] == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (route) => route == null,
      );
    } else if (mess["status"] == 'fail') {
      String errMessage = 'FAILED!\n';
      if (mess.containsKey("user")) {
        mess["user"].forEach((k, v) => errMessage = errMessage + k + ':' + v[0] + "\n");
      }
      if (mess.containsKey("gender")) {
        errMessage = errMessage + 'gender:' + mess["gender"][0] + '\n';
      }
      if (mess.containsKey("age")) {
        errMessage = errMessage + 'age:' + mess["age"][0] + '\n';
      }
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(errMessage), duration: Duration(milliseconds: 3000)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _signupForm(),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('SignUp'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _signup();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _signupForm() {
    return Container(
      width: 300,
      height: 300,
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
                    Icons.account_box,
                  ),
                  hintText: "User Name",
                ),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Flexible(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _firstnameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.account_box,
                          ),
                          hintText: "First Name",
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _lastnameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.account_box,
                          ),
                          hintText: "Last Name",
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ]),
            ),
            Flexible(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _genderController,
                        validator: (value) {
                          if ((value.isEmpty) ||
                              !((value == 'F') || (value == 'M'))) {
                            return 'Please enter F(female) or M(male)';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            CustomIcons.gender,
                          ),
                          hintText: "Gender(F/M)",
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _ageController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your age';
                          }
                          int age = int.tryParse(value) ?? -1;
                          if (age < 0) {
                            return 'Please enter correct age';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            CustomIcons.age,
                          ),
                          hintText: "Age",
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ]),
            ),
            Flexible(
              child: TextFormField(
                controller: _emailAddressController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter email';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return 'Please enter correct email';
                  }
                  return null;
                },
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
            Flexible(
              child: TextFormField(
                controller: _passwordAgainController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please confirm password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                  ),
                  hintText: "Confirm Password",
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
