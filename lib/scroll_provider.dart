import 'package:flutter/material.dart';

class ScrollProvider with ChangeNotifier {
  bool change = false;

  cchange() {
    change = !change;
    notifyListeners();
  }
}
