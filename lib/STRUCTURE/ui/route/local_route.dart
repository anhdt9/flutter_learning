import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/home_view.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/login_view.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/movie_view.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/tvshow_view.dart';

class LocalRouter {
  static const LOGIN = "login";
  static const HOME = '/';
  static const MOVIE = 'movie';
  static const TV_SHOW = 'tv_show';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginView());
        break;
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case MOVIE:
        return MaterialPageRoute(builder: (_) => MovieView());
        break;
      case TV_SHOW:
        return MaterialPageRoute(builder: (_) => TvShowView());
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
