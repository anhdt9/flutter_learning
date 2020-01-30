import 'dart:convert';

import 'package:flutter_app_learning/constants.dart';
import 'package:flutter_app_learning/models/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class Api {
  static const URL = 'https://api.themoviedb.org/';
  static const API_KEY = 'dbdd75aefbbd8a17489c25ec0fc8c9ef';

  static final Api _singleton = Api._internal();

  Api._internal();

  static Api get() => _singleton;

  var _fbLogin = FacebookLogin();

  Future<User> login(LOGIN_TYPE type, {String email, String password}) async {
    if (type == LOGIN_TYPE.facebook) {
      return _loginFb();
    } else if (type == LOGIN_TYPE.normal) {
      return _loginNormal(email, password);
    }
    return null;
  }

  Future<User> _loginFb() async {
    var facebookLoginResult = await _fbLogin.logIn(['email']);
    print("facebookLoginResult = ${facebookLoginResult.status}");

    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${facebookLoginResult.accessToken.token}');

      var profile = json.decode(graphResponse.body);
      print("fb user = ${profile.toString()}");
      return User.map(profile);
    }
    return null;
  }

  Future<User> _loginNormal(String email, String password) async {
    print("API, loginNormal");
    User xxx = new User("User id", "User name", email,
        "https://homepages.cae.wisc.edu/~ece533/images/girl.png");
    return xxx;
  }

  logout(LOGIN_TYPE type) async {
    if (type == LOGIN_TYPE.facebook) {
      await _logoutFb();
    } else if (type == LOGIN_TYPE.normal) {
      await _logoutNormal();
    }
  }

  _logoutFb() async {
    await _fbLogin.logOut();
  }

  _logoutNormal() async {
    print("API, logoutNormal");
  }
}
