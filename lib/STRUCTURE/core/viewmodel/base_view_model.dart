
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;

  set busy(bool value) {
    _busy = value;
    notifyListeners();
  }

  bool get busy => _busy;
}
