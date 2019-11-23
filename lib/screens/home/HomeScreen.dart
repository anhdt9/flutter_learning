import 'package:flutter/material.dart';
import 'package:flutter_app_learning/base/BaseAppBar.dart';
import 'package:flutter_app_learning/navigator/NavigatorController.dart';

import 'package:flutter_app_learning/screens/home/Home_Body.dart';
import 'package:flutter_app_learning/screens/home/Home_Drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text("Title"),
        appBar: AppBar(),
        actions: homeActions(context),
      ),
      drawer: MyDrawer(),
      body: MyBody(),
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
          onPressed: () => {NavigatorController.pop(context)}),
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
