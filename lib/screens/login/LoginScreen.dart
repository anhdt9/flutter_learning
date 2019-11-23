import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../navigator/NavigatorController.dart';
import '../home/HomeScreen.dart';
import 'LoginModel.dart';

class LoginScreen extends StatelessWidget {
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
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginViewModel = LoginModel();

  bool isFacebookLoggedIn = false;
  bool isGoogleLoggedIn = false;

  var facebookProfileData;
  var googleProfileData;
  var _facebookLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isFacebookLoggedIn = isLoggedIn;
      this.facebookProfileData = profileData;
      if (isLoggedIn) {
        print(
            "Fb login data : ${profileData['picture']['data']['url']}\n${profileData['id']}\n${profileData['name']}\n${profileData['email']}");
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
        print(profile.toString());

        onLoginStatusChanged(true, profileData: profile);
        break;
    }
  }

  _logoutFacebook() async {
    await _facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("_logoutFacebook");
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _loginGoogle() async {
    try {
      await _googleSignIn.signIn();
      isGoogleLoggedIn = true;
      print("_loginGoogle" +
          _googleSignIn.currentUser.email +
          ", " +
          _googleSignIn.currentUser.displayName +
          ", " +
          _googleSignIn.currentUser.photoUrl);
    } catch (err) {
      print(err);
    }
  }

  _logoutGoogle() async {
    await _googleSignIn.signOut();
    isGoogleLoggedIn = false;
    print("_logoutGoogle");
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });

    passwordController.addListener(() {
      loginViewModel.passwordSink.add(passwordController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    loginViewModel.dispose();
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
              stream: loginViewModel.emailStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Nhap email ...",
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
              stream: loginViewModel.passwordStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Nhap mat khau ...",
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
            width: 200,
            height: 40,
            child: StreamBuilder<bool>(
                stream: loginViewModel.btnStream,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Login with Facebook"),
                  onPressed: () => _loginFacebook(),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Login with Google"),
                  onPressed: () => _loginGoogle(),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            width: 200,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Logout"),
              onPressed: () {

                _googleSignIn.isSignedIn().then((result) => {
                  result ? _logoutGoogle() : {}
                }).catchError((err) => {print(err.toString())});

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
