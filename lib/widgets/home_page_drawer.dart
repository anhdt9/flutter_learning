import 'package:flutter/material.dart';
import 'package:flutter_app_learning/constants.dart';
import 'package:flutter_app_learning/models/user.dart';
import 'package:flutter_app_learning/viewmodels/LoginViewModel.dart';
import 'package:provider/provider.dart';

class HomePageDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.7
          : MediaQuery.of(context).size.height * 0.7,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
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
                          backgroundImage:
                          NetworkImage(Provider.of<User>(context).url),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    title: Text("First"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    trailing: RaisedButton(
                        child: Text("item1"),
                        color: Colors.blue,
                        onPressed: _drawerItemClick),
                  ),
                  ListTile(
                    title: Text("Second"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    trailing: RaisedButton(
                        child: Text("item2"),
                        color: Colors.blue,
                        onPressed: _drawerItemClick),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: 130,
              margin: EdgeInsets.only(bottom: 5.0),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  Provider.of<LoginViewModel>(context, listen: false)
                      .logout(LOGIN_TYPE.normal);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Logout",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.input)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _drawerItemClick() {
    print("_drawerItemClick, index = ");
  }
}
