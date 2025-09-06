
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/model/service_provider_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';


class ServiceProvider extends ChangeNotifier {
  final UserFirebaseService _userService = UserFirebaseService();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ServiceModel? _currentUser;
    String? userId;

  String? _gender;
  String? _imagePath;
  String? _identityImagePath;

  ServiceModel? get currentUser => _currentUser;
  String? get imagePath => _imagePath;
  String? get gender => _gender;
  String?get identityImagePath=>_identityImagePath;

  // Setters from UI
  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void setImage(String path) {
    _imagePath = path;
    notifyListeners();
  }

  void clearImage() {
    _imagePath = null;
    notifyListeners();
  }

  // READ user
  Future<void> fetchUser(String userId) async {
    _currentUser = await _userService.getUser(userId);

    // Sync UI state with fetched user data
    if (_currentUser != null) {
      _gender = _currentUser!.gender;
      _imagePath = _currentUser!.profilePhoto;
    }
    notifyListeners();
  }

  // CREATE user (includes _imagePath and _gender from UI)
  Future<void> saveUser(ServiceModel user) async {
    final updatedUser = user.copyWith(
      profilePhoto: _imagePath ?? user.profilePhoto,
      gender: _gender ?? user.gender,
    );

    await _userService.createOrUpdateUser(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }

  // UPDATE user (includes _imagePath and _gender from UI)
  Future<void> updateUser(Map<String, dynamic> updates) async {
    if (_currentUser == null) return;

    updates['profilePhoto'] = _imagePath ?? updates['profilePhoto'];
    updates['gender'] = _gender ?? updates['gender'];

    await _userService.updateUser(_currentUser!.userId, updates);

    _currentUser = _currentUser!.copyWith(
      profilePhoto: updates['profilePhoto'],
      name: updates['name'] ?? _currentUser!.name,
      gender: updates['gender'],
      phoneNumber: updates['phoneNumber'] ?? _currentUser!.phoneNumber,
      email: updates['email'] ?? _currentUser!.email,
    );
    notifyListeners();
  }

  // DELETE user
  Future<void> deleteUser() async {
    if (_currentUser == null) return;
    await _userService.deleteUser(_currentUser!.userId);
    _currentUser = null;
    _gender = null;
    _imagePath = null;
    notifyListeners();
  }

    Future<String?> checkUserRegistration() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot userQuery = await _firestore
          .collection('services')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        this.userId = userQuery.docs.first.id;
        return this.userId;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error checking hotel registration: $e');
      return null;
    }
  }
}
