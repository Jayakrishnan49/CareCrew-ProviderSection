import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  String? _selectedGender;
  String? _selectedService;

  String? get selectedGender => _selectedGender;
  String? get selectedService => _selectedService;

  void setGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setService(String? service) {
    _selectedService = service;
    notifyListeners();
  }
}
