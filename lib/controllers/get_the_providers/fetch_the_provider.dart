// import 'package:flutter/material.dart';
// import 'package:project_2_provider/model/user_model.dart';
// import 'package:project_2_provider/services/service_provider_service.dart';

// class PermissionServiceProvider extends ChangeNotifier {
//   final PermissionServiceRepository _repository = PermissionServiceRepository();

//   List<UserModel> _approvedServices = [];
//   List<UserModel> get approvedServices => _approvedServices;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   Future<void> fetchApprovedServices() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _approvedServices = await _repository.fetchApprovedServices();
//     } catch (e) {
//       _errorMessage = e.toString();
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
