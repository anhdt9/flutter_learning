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
            tabs: [
              Tab(
                icon: new Icon(Icons.movie),
              ),
              Tab(
                icon: new Icon(Icons.tv),
              ),
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
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
