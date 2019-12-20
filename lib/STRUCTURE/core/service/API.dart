import 'package:flutter_app_learning/STRUCTURE/core/model/User.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const URL = 'https://api.themoviedb.org/';
  static const API_KEY = 'dbdd75aefbbd8a17489c25ec0fc8c9ef';

  var _fbLogin = FacebookLogin();

  Future<User> loginFb() async {
    var facebookLoginResult = await _fbLogin.logInWithReadPermissions(['email']);
    print("facebookLoginResult = ${facebookLoginResult.status}");

    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.width(400)&access_token=${facebookLoginResult.accessToken.token}');

      var profile = json.decode(graphResponse.body);
      return User.map(profile);
    }
    return null;
  }

  logoutFb() async {
    await _fbLogin.logOut();
  }

  Future<bool> loginNormal() async {}

  Future<void> logoutNormal() async {}
}
