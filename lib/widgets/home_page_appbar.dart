import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double smallSpace = 10;

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height + 2 * smallSpace);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final double smallSpace = 10;
  final blue = Colors.blue;
  var _searchModeController = BehaviorSubject<bool>();

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
            leading: StreamBuilder<bool>(
                stream: _searchModeController.stream.asBroadcastStream(),
                builder: (context, snapshot) {
                  return IconButton(
                    icon: Icon((snapshot.data == true)
                        ? Icons.arrow_back
                        : Icons.menu),
                    color: blue,
                    onPressed: () {
                      if (snapshot.data == false) {
                        Scaffold.of(context).openDrawer();
                      } else {
                        _searchModeController.add(false);
                        FocusScope.of(context).unfocus();
                      }
                    },
                  );
                }),
            primary: false,
            title: TextField(
                onTap: () {
                  _searchModeController.add(true);
                },
                decoration: InputDecoration(
                  hintText: "Search here...",
                  border: InputBorder.none,
                )),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications, color: blue),
                onPressed: () {
                  print("action notifications");
                },
              )
            ],
          ),
        ),
        // Text("Hello"),
      ],
    );
  }

  @override
  void dispose() {
    _searchModeController.close();
    super.dispose();
  }
}
