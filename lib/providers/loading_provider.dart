import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  // Method to start the loading process
  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  // Method to stop the loading process
  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
