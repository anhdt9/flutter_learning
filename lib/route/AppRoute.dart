import 'package:flutter/cupertino.dart';
import 'package:flutter_app_learning/helper/SharedPreferenceManager.dart';
import 'package:flutter_app_learning/screens/home/HomeScreen.dart';
import 'package:flutter_app_learning/screens/login/LoginScreen.dart';

class AppRoute {
  static const LOGIN_SCREEN = "LoginScreen";
  static const HOME_SCREEN = "HomeScreen";

  static getAppRoute(BuildContext context) => {
        LOGIN_SCREEN: (context) => LoginScreen(),
        HOME_SCREEN: (context) => HomeScreen(),
      };

  static String getInitRoute(BuildContext context) {
    String id;
    SharedPreferenceManager.getString(SharedPreferenceManager.PREF_ID).then((
        value) => {id = value});
    if (id != null) {
      return HOME_SCREEN;
    } else {
      return LOGIN_SCREEN;
    }
  }
}
