import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isBottomNavVisible = true;
  
  int get currentIndex => _currentIndex;
  bool get isBottomNavVisible => _isBottomNavVisible;
  
  void setIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void hideBottomNav() {
    if (_isBottomNavVisible) {
      _isBottomNavVisible = false;
      notifyListeners();
    }
  }

  void showBottomNav() {
    if (!_isBottomNavVisible) {
      _isBottomNavVisible = true;
      notifyListeners();
    }
  }
  
  // Optional: Reset to home when needed
  void resetToHome() {
    _currentIndex = 0;
    notifyListeners();
  }
}