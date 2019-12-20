import 'package:flutter/material.dart';
import 'package:flutter_app_learning/STRUCTURE/core/model/User.dart';

class HomeViewDrawer extends Container {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: StreamBuilder<User>(
//        stream: _loginViewModel.userStream,
        builder: (context, snapshot) {

          User user = snapshot.data;
          print("MyDrawer, user = " + user.toString());

          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Text(
                      user.name,
                      textAlign: TextAlign.center,
                      textScaleFactor: 2.0,
                    ),
                    Image.network(user.url, width: 40, height: 40,),
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
          );
        }
      ),
    );
  }

  _drawerItemClick() {
    print("_drawerItemClick, index = ");
  }
}
