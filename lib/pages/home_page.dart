import 'package:flutter/material.dart';
import 'package:flutter_app_learning/pages/home_page_body.dart';
import 'package:flutter_app_learning/widgets/home_page_appbar.dart';
import 'package:flutter_app_learning/widgets/home_page_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: HomeAppBar(),
      drawer: HomePageDrawer(),
      body: HomePageBody(),
    );
    Container();
  }
}
