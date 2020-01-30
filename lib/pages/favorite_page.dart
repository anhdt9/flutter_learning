import 'package:flutter/material.dart';
import 'package:flutter_app_learning/pages/movie_page.dart';
import 'package:flutter_app_learning/pages/tvshow_page.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
            tabs: [
              Container(
                child: Tab(
                    child: Text(
                  "Movie",
                  style: TextStyle(fontSize: 11),
                )),
                height: 30,
              ),
              Container(
                child: Tab(
                    child: Text(
                  "Tv Show",
                  style: TextStyle(fontSize: 11),
                )),
                height: 30,
              ),
            ],
          ),
          body: TabBarView(
            children: [
              MoviePage(),
              TvShowPage(),
            ],
          ),
        ));
  }
}
