import 'package:flutter/material.dart';
import 'package:flutter_app_learning/models/user.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends Container {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text(
                  Provider.of<User>(context).name,
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(Provider.of<User>(context).url),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.green),
          ),
          ListTile(
            title: Text("First"),
            onTap: () {
              Navigator.pop(context);
            },
            trailing: RaisedButton(
                child: Text("item1"),
                color: Colors.amberAccent,
                onPressed: _drawerItemClick),
          ),
          ListTile(
            title: Text("Second"),
            onTap: () {
              Navigator.pop(context);
            },
            trailing: RaisedButton(
                child: Text("item2"),
                color: Colors.amberAccent,
                onPressed: _drawerItemClick),
          )
        ],
      ),
    );
  }

  _drawerItemClick() {
    print("_drawerItemClick, index = ");
  }
}
