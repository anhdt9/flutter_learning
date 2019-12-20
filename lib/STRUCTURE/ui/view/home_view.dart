import 'package:flutter/material.dart';
import 'package:flutter_app_learning/STRUCTURE/core/model/User.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/home_view_body.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/view/home_view_drawer.dart';
import 'package:flutter_app_learning/STRUCTURE/ui/BaseAppBar.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {

    // for test -> OK
    User user = ModalRoute.of(context).settings.arguments;
//    print("HomeScreen, get route arguments : " + user.toString());

    return Scaffold(
      appBar: BaseAppBar(
        title: Text("Title"),
        appBar: AppBar(),
        actions: homeActions(context),
      ),
      drawer: HomeViewDrawer(),
      body: HomeViewBody(),
    );
  }

  List<Widget> homeActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          tooltip: "Back",
          onPressed: () => {Navigator.pop(context)}),
      IconButton(
          icon: Icon(
            Icons.ac_unit,
            color: Colors.lime,
          ),
          onPressed: () => {print("menu ac_unit")}),
      IconButton(
          icon: Icon(
            Icons.cached,
            color: Colors.cyanAccent,
          ),
          onPressed: () => {print("menu cached")}),
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Title(color: Colors.green, child: Text("Menu1"))),
          PopupMenuItem(
              value: 2,
              child: Title(color: Colors.green, child: Text("Menu12"))),
        ],
        onSelected: (index) => {print(index.toString())},
      )
    ];
  }
}

