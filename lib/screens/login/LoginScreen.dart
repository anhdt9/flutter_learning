import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_learning/base/BaseScreen.dart';
import 'package:flutter_app_learning/data/User.dart';
import 'package:flutter_app_learning/helper/SharedPreferenceManager.dart';
import 'package:flutter_app_learning/route/AppRoute.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

import '../../navigator/NavigatorController.dart';
import '../home/HomeScreen.dart';
import 'LoginModel.dart';

class LoginScreen extends BaseScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
        ),
      ),
      body: LoginBody(),
    );
  }

  @override
  getScreenName() {
    return "LoginScreen";
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginViewModel = LoginModel();

  bool _isFacebookLoggedIn = false;

  var _facebookProfileData;
  var _facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this._isFacebookLoggedIn = isLoggedIn;
      this._facebookProfileData = profileData;
      if (isLoggedIn) {
        String id = profileData['id'];
        String name = profileData['name'];
        String email = profileData['email'];
        String url = profileData['picture']['data']['url'];

        SharedPreferenceManager.setString(SharedPreferenceManager.PREF_ID, id);
        SharedPreferenceManager.setString(SharedPreferenceManager.PREF_NAME, name);
        SharedPreferenceManager.setString(SharedPreferenceManager.PREF_EMAIL, email);
        SharedPreferenceManager.setString(SharedPreferenceManager.PREF_URL, url);
        SharedPreferenceManager.setBool(SharedPreferenceManager.PREF_LOGIN, true);

        User user = new User.map(profileData);
        print("onLoginStatusChanged, isLoggedIn = true, data = " + user.toString());
        _loginViewModel.userSink.add(user);

        Navigator.pushNamed(context, AppRoute.HOME_SCREEN, arguments:user);
      } else {
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_ID);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_NAME);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_EMAIL);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_URL);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_LOGIN);
      }
    });
  }

  _loginFacebook() async {
    var facebookLoginResult =
        await _facebookLogin.logInWithReadPermissions(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        onLoginStatusChanged(true, profileData: profile);
        break;
    }
  }

  _logoutFacebook() async {
    await _facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("_logoutFacebook");
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _loginViewModel.emailSink.add(_emailController.text);
    });

    _passwordController.addListener(() {
      _loginViewModel.passwordSink.add(_passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.dispose();
    print("loginViewModel.dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: _loginViewModel.emailStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "abc@gmail.com",
                    labelText: "Email",
                    icon: Icon(Icons.email),
                    errorText: snapshot.data,
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<String>(
              stream: _loginViewModel.passwordStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "123456",
                    labelText: "Mat khau",
                    icon: Icon(Icons.lock),
                    errorText: snapshot.data,
                  ),
                );
              }),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 150,
            height: 40,
            child: StreamBuilder<bool>(
                stream: _loginViewModel.btnStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    onPressed: snapshot.data == true
                        ? () {
                            print("login call API");
                            NavigatorController.push(context, HomeScreen());
                          }
                        : null,
                    child: Text("Login"),
                  );
                }),
          ),
          SizedBox(
            width: 150,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Login with Facebook",
                style: TextStyle(fontSize: 11),
              ),
              onPressed: () => _loginFacebook(),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            width: 200,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Logout"),
              onPressed: () {
                _facebookLogin.isLoggedIn
                    .then((result) => {result ? _logoutFacebook() : {}})
                    .catchError((err) => {print(err.toString())});
              },
            ),
          )
        ],
      ),
    );
  }
}