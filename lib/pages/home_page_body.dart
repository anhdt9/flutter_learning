import 'package:flutter/material.dart';
import 'package:flutter_app_learning/pages/favorite_page.dart';
import 'package:flutter_app_learning/pages/movie_page.dart';
import 'package:flutter_app_learning/pages/tvshow_page.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          bottomNavigationBar: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.movie),
                  child: Text(
                    "Movie",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Tab(
                  icon: new Icon(Icons.tv),
                  child: Text(
                    "Tv Show",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Tab(
                  icon: new Icon(Icons.favorite),
                  child: Text(
                    "Favorite",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.red,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MoviePage(),
              TvShowPage(),
              FavouritePage(),
            ],
          ),
        ));
  }
}
