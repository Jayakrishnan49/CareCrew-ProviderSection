// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:image_picker/image_picker.dart';
// import 'package:project_2_provider/model/user_model.dart';
// import 'package:project_2_provider/services/user_firebase_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum SaveState { idle, saving, success, error }

// class PersonalDetailsProvider extends ChangeNotifier {
//   final UserFirebaseService _userService = UserFirebaseService();
//   final String providerId = FirebaseAuth.instance.currentUser?.uid ?? '';

//   // ── State ─────────────────────────────────────────────────────────────────
//   UserModel? _user;
//   bool _isLoading = false;
//   bool _isEditing = false;
//   SaveState _saveState = SaveState.idle;
//   String? _errorMessage;
//   File? _pickedImage;

//   // ── Controllers (initialized when editing starts) ─────────────────────────
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   late TextEditingController emailController;

//   // ── Getters ───────────────────────────────────────────────────────────────
//   UserModel? get user => _user;
//   bool get isLoading => _isLoading;
//   bool get isEditing => _isEditing;
//   SaveState get saveState => _saveState;
//   String? get errorMessage => _errorMessage;
//   File? get pickedImage => _pickedImage;

//   // ── Load user ─────────────────────────────────────────────────────────────
//   Future<void> loadUser() async {
//     _isLoading = true;
//     notifyListeners();
//     _user = await _userService.getUser(providerId);
//     _isLoading = false;
//     notifyListeners();
//   }

//   // ── Toggle edit mode ──────────────────────────────────────────────────────
//   void startEditing() {
//     nameController = TextEditingController(text: _user?.name ?? '');
//     phoneController = TextEditingController(text: _user?.phoneNumber ?? '');
//     emailController = TextEditingController(text: _user?.email ?? '');
//     _pickedImage = null;
//     _isEditing = true;
//     _saveState = SaveState.idle;
//     notifyListeners();
//   }

//   void cancelEditing() {
//     _isEditing = false;
//     _pickedImage = null;
//     _saveState = SaveState.idle;
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     notifyListeners();
//   }

//   // ── Pick image from gallery ───────────────────────────────────────────────
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );
//     if (picked != null) {
//       _pickedImage = File(picked.path);
//       notifyListeners();
//     }
//   }

//   // ── Upload to Cloudinary ──────────────────────────────────────────────────
//   Future<String?> _uploadToCloudinary(File imageFile) async {
//     const cloudName = 'dq4gjskwm'; // your cloudinary cloud name
//     const uploadPreset = 'user_profile_image'; // replace with your preset

//     final uri =
//         Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

//     final request = http.MultipartRequest('POST', uri)
//       ..fields['upload_preset'] = uploadPreset
//       ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

//     final response = await request.send();
//     if (response.statusCode == 200) {
//       final body = await response.stream.bytesToString();
//       final json = jsonDecode(body);
//       return json['secure_url'] as String?;
//     }
//     return null;
//   }

//   // ── Save changes ──────────────────────────────────────────────────────────
//   Future<void> saveChanges() async {
//     _saveState = SaveState.saving;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       String photoUrl = _user?.profilePhoto ?? '';

//       // Upload new photo if picked
//       if (_pickedImage != null) {
//         final uploaded = await _uploadToCloudinary(_pickedImage!);
//         if (uploaded != null) {
//           photoUrl = uploaded;
//         } else {
//           throw Exception('Failed to upload profile photo');
//         }
//       }

//       final updates = {
//         'name': nameController.text.trim(),
//         'phoneNumber': phoneController.text.trim(),
//         'email': emailController.text.trim(),
//         'profilePhoto': photoUrl,
//       };

//       await _userService.updateUser(providerId, updates);

//       // Update local model
//       _user = _user?.copyWith(
//         name: nameController.text.trim(),
//         phoneNumber: phoneController.text.trim(),
//         email: emailController.text.trim(),
//         profilePhoto: photoUrl,
//       );

//       _saveState = SaveState.success;
//       _isEditing = false;
//       _pickedImage = null;
//       nameController.dispose();
//       phoneController.dispose();
//       emailController.dispose();
//     } catch (e) {
//       _saveState = SaveState.error;
//       _errorMessage = e.toString();
//     }

//     notifyListeners();
//   }

//   // ── Send change request to admin ──────────────────────────────────────────
//   Future<void> sendChangeRequest({
//     required String requestType,
//     required String description,
//   }) async {
//     await FirebaseFirestore.instance.collection('admin_change_requests').add({
//       'providerId': providerId,
//       'providerName': _user?.name ?? '',
//       'requestType': requestType,
//       'description': description,
//       'status': 'pending',
//       'createdAt': Timestamp.now(),
//     });
//   }

//   @override
//   void dispose() {
//     if (_isEditing) {
//       nameController.dispose();
//       phoneController.dispose();
//       emailController.dispose();
//     }
//     super.dispose();
//   }
// }








import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_2_provider/model/user_model.dart';
import 'package:project_2_provider/model/service_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';

enum SaveState { idle, saving, success, error }

class PersonalDetailsProvider extends ChangeNotifier {
  final UserFirebaseService _userService = UserFirebaseService();
  final String providerId = FirebaseAuth.instance.currentUser?.uid ?? '';

  static const String _cloudName = 'dq4gjskwm';
  static const String _uploadPreset = 'user_profile_image';

  // ── State ─────────────────────────────────────────────────────────────────
  UserModel? _user;
  bool _isLoading = false;
  bool _isEditing = false;
  SaveState _saveState = SaveState.idle;
  SaveState _requestState = SaveState.idle;
  String? _errorMessage;
  File? _pickedProfileImage;

  // ── Services dropdown ─────────────────────────────────────────────────────
  List<WorkModel> _services = [];
  bool _servicesLoading = false;
  String? selectedServiceForRequest;

  // ── Document images for change request ────────────────────────────────────
  File? _idCardImage;
  File? _certificateImage;

  // ── Edit controllers (personal details tab) ───────────────────────────────
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController experienceController;
  late TextEditingController firstHourPriceController;
  String? selectedGender;

  // ── Change request controllers (documents tab) ────────────────────────────
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController bankIfscController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();

  // ── Getters ───────────────────────────────────────────────────────────────
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  SaveState get saveState => _saveState;
  SaveState get requestState => _requestState;
  String? get errorMessage => _errorMessage;
  File? get pickedProfileImage => _pickedProfileImage;
  List<WorkModel> get services => _services;
  bool get servicesLoading => _servicesLoading;
  File? get idCardImage => _idCardImage;
  File? get certificateImage => _certificateImage;

  // ── Load ──────────────────────────────────────────────────────────────────
  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();
    _user = await _userService.getUser(providerId);
    _isLoading = false;
    notifyListeners();
    await _fetchServices();
  }

  Future<void> _fetchServices() async {
    _servicesLoading = true;
    notifyListeners();
    _services = await _userService.getAllServices();
    _servicesLoading = false;
    notifyListeners();
  }

  // ── Edit mode ─────────────────────────────────────────────────────────────
  void startEditing() {
    nameController = TextEditingController(text: _user?.name ?? '');
    phoneController = TextEditingController(text: _user?.phoneNumber ?? '');
    emailController = TextEditingController(text: _user?.email ?? '');
    locationController = TextEditingController(text: _user?.location ?? '');
    experienceController =
        TextEditingController(text: _user?.yearsOfexperience ?? '');
    firstHourPriceController =
        TextEditingController(text: _user?.firstHourPrice ?? '');
    selectedGender = _user?.gender;
    _pickedProfileImage = null;
    _isEditing = true;
    _saveState = SaveState.idle;
    notifyListeners();
  }

  void cancelEditing() {
    _disposeEditControllers();
    _isEditing = false;
    _pickedProfileImage = null;
    _saveState = SaveState.idle;
    notifyListeners();
  }

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setSelectedServiceForRequest(String? service) {
    selectedServiceForRequest = service;
    notifyListeners();
  }

  void _disposeEditControllers() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    experienceController.dispose();
    firstHourPriceController.dispose();
  }

  // ── Image picking ─────────────────────────────────────────────────────────
  Future<void> pickProfileImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      _pickedProfileImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> pickIdCardImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      _idCardImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> pickCertificateImage() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      _certificateImage = File(picked.path);
      notifyListeners();
    }
  }

  // ── Cloudinary upload ─────────────────────────────────────────────────────
  Future<String?> uploadToCloudinary(File imageFile) async {
    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = _uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final json = jsonDecode(body);
      return json['secure_url'] as String?;
    }
    return null;
  }

  // ── Save personal details ─────────────────────────────────────────────────
  Future<void> saveChanges() async {
    _saveState = SaveState.saving;
    _errorMessage = null;
    notifyListeners();

    try {
      String photoUrl = _user?.profilePhoto ?? '';
      if (_pickedProfileImage != null) {
        final uploaded = await uploadToCloudinary(_pickedProfileImage!);
        if (uploaded == null) throw Exception('Failed to upload profile photo');
        photoUrl = uploaded;
      }

      final updates = {
        'name': nameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'location': locationController.text.trim(),
        'yearsOfexperience': experienceController.text.trim(),
        'firstHourPrice': firstHourPriceController.text.trim(),
        'gender': selectedGender ?? _user?.gender ?? '',
        'profilePhoto': photoUrl,
      };

      await _userService.updateUser(providerId, updates);

      _user = _user?.copyWith(
        name: nameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        email: emailController.text.trim(),
        location: locationController.text.trim(),
        yearsOfexperience: experienceController.text.trim(),
        firstHourPrice: firstHourPriceController.text.trim(),
        gender: selectedGender ?? _user?.gender ?? '',
        profilePhoto: photoUrl,
      );

      _disposeEditControllers();
      _isEditing = false;
      _pickedProfileImage = null;
      _saveState = SaveState.success;
    } catch (e) {
      _saveState = SaveState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // ── Change requests ───────────────────────────────────────────────────────
  Future<void> sendDocumentChangeRequest() async {
    if (_idCardImage == null && _certificateImage == null) return;
    _requestState = SaveState.saving;
    notifyListeners();

    try {
      final Map<String, dynamic> requestData = {
        'providerId': providerId,
        'providerName': _user?.name ?? '',
        'type': 'document_update',
        'status': 'pending',
        'createdAt': Timestamp.now(),
      };

      if (_idCardImage != null) {
        final url = await uploadToCloudinary(_idCardImage!);
        if (url == null) throw Exception('Failed to upload ID card');
        requestData['newIdCardPhoto'] = url;
      }

      if (_certificateImage != null) {
        final url = await uploadToCloudinary(_certificateImage!);
        if (url == null) throw Exception('Failed to upload certificate');
        requestData['newExperienceCertificate'] = url;
      }

      await FirebaseFirestore.instance
          .collection('admin_change_requests')
          .add(requestData);

      _idCardImage = null;
      _certificateImage = null;
      _requestState = SaveState.success;
    } catch (e) {
      _requestState = SaveState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> sendServiceChangeRequest() async {
    if (selectedServiceForRequest == null) return;
    _requestState = SaveState.saving;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('admin_change_requests')
          .add({
        'providerId': providerId,
        'providerName': _user?.name ?? '',
        'type': 'service_update',
        'newService': selectedServiceForRequest,
        'currentService': _user?.selectService ?? '',
        'status': 'pending',
        'createdAt': Timestamp.now(),
      });

      selectedServiceForRequest = null;
      _requestState = SaveState.success;
    } catch (e) {
      _requestState = SaveState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> sendBankChangeRequest() async {
    _requestState = SaveState.saving;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('admin_change_requests')
          .add({
        'providerId': providerId,
        'providerName': _user?.name ?? '',
        'type': 'bank_update',
        'status': 'pending',
        'createdAt': Timestamp.now(),
        'newBankDetails': {
          'accountHolderName': accountHolderController.text.trim(),
          'bankAccountNumber': bankAccountController.text.trim(),
          'bankIfscCode': bankIfscController.text.trim().toUpperCase(),
          'bankName': bankNameController.text.trim(),
          'upiId': upiController.text.trim(),
        },
      });

      accountHolderController.clear();
      bankAccountController.clear();
      bankIfscController.clear();
      bankNameController.clear();
      upiController.clear();
      _requestState = SaveState.success;
    } catch (e) {
      _requestState = SaveState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> sendBusinessNameChangeRequest() async {
    if (businessNameController.text.trim().isEmpty) return;
    _requestState = SaveState.saving;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('admin_change_requests')
          .add({
        'providerId': providerId,
        'providerName': _user?.name ?? '',
        'type': 'business_name_update',
        'newBusinessName': businessNameController.text.trim(),
        'currentBusinessName': _user?.businessName ?? '',
        'status': 'pending',
        'createdAt': Timestamp.now(),
      });

      businessNameController.clear();
      _requestState = SaveState.success;
    } catch (e) {
      _requestState = SaveState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void resetRequestState() {
    _requestState = SaveState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  void resetSaveState() {
    _saveState = SaveState.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_isEditing) _disposeEditControllers();
    bankAccountController.dispose();
    bankIfscController.dispose();
    bankNameController.dispose();
    accountHolderController.dispose();
    upiController.dispose();
    businessNameController.dispose();
    super.dispose();
  }
}