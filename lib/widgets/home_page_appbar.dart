import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  final double smallSpace = 10;
  final red500 = Colors.red[500];

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Stack(
      children: <Widget>[
        Positioned(
          top: statusBarHeight + smallSpace,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.menu,
              color: red500,
            ),
            primary: false,
            title: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: red500),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: red500),
                onPressed: () {},
              )
            ],
          ),
        ),
        // Text("Hello"),
      ],
    );
  }

  @override
  // TODO: implement child
  Widget get child => null;

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height + 2 * smallSpace);
}
