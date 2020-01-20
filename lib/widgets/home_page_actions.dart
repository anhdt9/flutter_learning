

import 'package:flutter/material.dart';
import 'package:flutter_app_learning/local_route.dart';

List<Widget> homeActions(BuildContext context) {
  return <Widget>[
    IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        tooltip: "Back",
        onPressed: () => {
          Navigator.pushNamed(context, LocalRouter.LOGIN)
        }),
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