import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_learning/TEST/viewmodels/LoginViewModel2.dart';
import 'package:provider/provider.dart';

class LoginPage2 extends StatefulWidget {
  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  bool passwordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => LoginViewModel2(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 40, right: 40, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/1.jpg"),
                  ),
                ),
                Text(
                  "Hello Dang The Anh",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "Welcome back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter email",
                      icon: Icon(Icons.email),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _passWordController,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter password",
                      icon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Center(
                    child: MaterialButton(
                      onPressed: _loginClick,
                      color: Colors.blue,
                      minWidth: 200,
                      splashColor: Colors.red,
                      child: Text("LOGIN"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: "NEW USER?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: " SIGN UP",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("SIGN UP click!");
                                  },
                              )
                            ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("FORGOT PASSWORD click!");
                        },
                        child: Text(
                          "FORGOT PASSWORD?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 8),
                    child: Text(
                      "Or Sign in with",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print("facebook click!");
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/facebook.png"),
                          radius: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("google click!");
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/google.png"),
                          radius: 25,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginClick() {}
}
