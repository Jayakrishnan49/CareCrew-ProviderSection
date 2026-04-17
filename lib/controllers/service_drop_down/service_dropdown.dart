import 'package:flutter/material.dart';
import 'package:project_2_provider/model/service_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';

class DropProvider with ChangeNotifier {
  List<WorkModel> _services = [];
  String? _selectedService;
  bool _isLoading = false;

  List<WorkModel> get services => _services;
  String? get selectedService => _selectedService;
  bool get isLoading => _isLoading;

  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    final userFirebaseService = UserFirebaseService();
    _services = await userFirebaseService.getAllServices();
    
    _isLoading = false;
    notifyListeners();
  }

  void setSelectedService(String? serviceName) {
    _selectedService = serviceName;
    notifyListeners();
  }
  
}