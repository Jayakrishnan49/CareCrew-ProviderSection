import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  String? _selectedGender;
  String? _selectedServiceName;

  String? get selectedGender => _selectedGender;
  String? get selectedService => _selectedServiceName;

  void setGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setService(String? service) {
    _selectedServiceName = service;
    notifyListeners();
  }
}
