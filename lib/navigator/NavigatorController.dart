import 'package:flutter/material.dart';

class NavigatorController {
  static push(BuildContext context, Widget toWidget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => toWidget));
  }

  static pop(BuildContext context){
    Navigator.pop(context);
  }
}
