import 'package:flutter/material.dart';

class MyDrawer extends Container {
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
                  "Dang The Anh",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                ),
                Image.asset("./images/1.jpg", width: 40, height: 40,),
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
                child: Text("item1"), color: Colors.amberAccent, onPressed: _drawerItemClick),
          ),
          ListTile(
            title: Text("Second"),
            onTap: () {
              Navigator.pop(context);
            },
            trailing: RaisedButton(
                child: Text("item2"), color: Colors.amberAccent,onPressed: _drawerItemClick),
          )
        ],
      ),
    );
  }

  _drawerItemClick() {
    print("_drawerItemClick, index = ");
  }
}
