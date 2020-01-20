import 'package:flutter/material.dart';
import 'package:flutter_app_learning/pages/home_page_body.dart';
import 'package:flutter_app_learning/widgets/home_page_appbar.dart';
import 'package:flutter_app_learning/widgets/home_page_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      drawer: HomePageDrawer(),
      body: HomePageBody(),
    );
  }
}
