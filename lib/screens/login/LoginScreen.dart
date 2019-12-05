import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_learning/base/BaseScreen.dart';
import 'package:flutter_app_learning/data/User.dart';
import 'package:flutter_app_learning/helper/SharedPreferenceManager.dart';
import 'package:flutter_app_learning/route/AppRoute.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
      body: ChangeNotifierProvider(
          create: (_) => LoginBloc(), child: LoginBody()),
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

  var _facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      if (isLoggedIn) {
        String id = profileData['id'];
        String name = profileData['name'];
        String email = profileData['email'];
        String url = profileData['picture']['data']['url'];

        SharedPreferenceManager.setString(SharedPreferenceManager.PREF_ID, id);
        SharedPreferenceManager.setString(
            SharedPreferenceManager.PREF_NAME, name);
        SharedPreferenceManager.setString(
            SharedPreferenceManager.PREF_EMAIL, email);
        SharedPreferenceManager.setString(
            SharedPreferenceManager.PREF_URL, url);

        User user = new User.map(profileData);
        print("onLoginStatusChanged, isLoggedIn = true, data = " +
            user.toString());
        LoginBloc.of(context).userSink.add(user);

        Navigator.pushNamed(context, AppRoute.HOME_SCREEN, arguments: user);
      } else {
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_ID);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_NAME);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_EMAIL);
        SharedPreferenceManager.remove(SharedPreferenceManager.PREF_URL);
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
      LoginBloc.of(context).emailSink.add(_emailController.text);
    });

    _passwordController.addListener(() {
      LoginBloc.of(context).passwordSink.add(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var loginBloc = LoginBloc.of(context);

    StreamController<ConnectivityResult> _controller =
        StreamController<ConnectivityResult>();

    Connectivity()
        .onConnectivityChanged
        .listen((onData) => {_controller.add(onData)});

    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          right: 20,
          child: StreamBuilder<ConnectivityResult>(
            initialData: ConnectivityResult.none,
            stream: _controller.stream,
            builder: (context, data) => Text("Network status : " +(data.data == ConnectivityResult.none ? "_No connection_" : (data.data == ConnectivityResult.mobile ? "_4G_" : "_Wifi_") ),
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                  stream: loginBloc.emailStream,
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
                  stream: loginBloc.passwordStream,
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
                    stream: loginBloc.btnStream,
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
        ),
      ],
    );
  }
}
