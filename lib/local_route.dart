import 'package:flutter/material.dart';
import 'package:flutter_app_learning/pages/home_page.dart';
import 'package:flutter_app_learning/pages/login_page.dart';
import 'package:flutter_app_learning/pages/movie_page.dart';
import 'package:flutter_app_learning/pages/tvshow_page.dart';

class LocalRouter {
  static const LOGIN = "login";
  static const HOME = "/";
  static const MOVIE = "movie";
  static const TV_SHOW = "tv_show";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("settings.name = ${settings.name}");
    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case MOVIE:
        return MaterialPageRoute(builder: (_) => MoviePage());
        break;
      case TV_SHOW:
        return MaterialPageRoute(builder: (_) => TvShowPage());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
