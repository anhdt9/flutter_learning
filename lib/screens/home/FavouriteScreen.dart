import 'package:flutter/material.dart';

import 'package:flutter_app_learning/screens/home/MovieScreen.dart';
import 'package:flutter_app_learning/screens/home/TvShowScreen.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          backgroundColor: Colors.brown,
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
              MovieScreen(),
              TvShowScreen(),
            ],
          ),
        ));
  }
}
