import 'package:flutter/material.dart';
import 'package:Graminsta/custom_icons_icons.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            onPressed: () {},
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: TextFormField(
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
            Flexible(
              child: TextFormField(
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
