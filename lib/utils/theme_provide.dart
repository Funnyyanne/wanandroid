import 'package:flutter/material.dart';

class ThemeProvide with ChangeNotifier {
  late int _themeIndex;

  int get value => _themeIndex;

  ThemeProvide();

  void setTheme(int index) async {
    _themeIndex = index;
    notifyListeners();
  }
}
