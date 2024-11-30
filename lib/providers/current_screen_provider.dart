import 'package:flutter/material.dart';

class CurrentScreenProvider extends ChangeNotifier {
  int _currentScreen = 0;

  /// Current visible screen
  int get currentScreen => _currentScreen;

  /// changing the screen on navigation in main screen
  void changeScreen(int index) {
    _currentScreen = index;
    notifyListeners();
  }
}
