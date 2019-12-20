import 'package:flutter/material.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/favorite_view.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/movie_view.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/tvshow_view.dart';

class HomeViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.movie),
              ),
              Tab(
                icon: new Icon(Icons.tv),
              ),
              Tab(
                icon: new Icon(Icons.favorite),
              ),
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MovieView(),
              TvShowView(),
              FavouriteView(),
            ],
          ),
        ));
  }
}
