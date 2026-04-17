// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:flutter/material.dart';
// import 'package:project_2_provider/model/user_model.dart';
// import 'package:project_2_provider/services/user_firebase_service.dart';

// class ServiceProvider extends ChangeNotifier {
//   final UserFirebaseService _userService = UserFirebaseService();

//   UserModel? _currentUser;
//   String? userId;
//   bool? _isApproved;
//   String? _approvalStatus;

//   String? _gender;
//   String? _imagePath;
//   String? _identityImagePath;
//   bool _isCheckingApproval = false;

//   UserModel? get currentUser => _currentUser;
//   String? get imagePath => _imagePath;
//   String? get gender => _gender;
//   String? get identityImagePath => _identityImagePath;
//   bool? get isApproved => _isApproved;
//   String? get approvalStatus => _approvalStatus;
  
//   bool get isCheckingApproval => _isCheckingApproval;

//   // Setters from UI
//   void setGender(String? value) {
//     _gender = value;
//     notifyListeners();
//   }

//   void setImage(String path) {
//     _imagePath = path;
//     notifyListeners();
//   }

//   void clearImage() {
//     _imagePath = null;
//     notifyListeners();
//   }

//   void setIdentityImage(String path) {
//     _identityImagePath = path;
//     notifyListeners();
//   }

//   void clearIdentityImage() {
//     _identityImagePath = null;
//     notifyListeners();
//   }



//   // READ user
//   Future<void> fetchUser(String userId) async {
//     _currentUser = await _userService.getUser(userId);

//     // Sync UI state with fetched user data
//     if (_currentUser != null) {
//       _gender = _currentUser!.gender;
//       _imagePath = _currentUser!.profilePhoto;
//     }
//     notifyListeners();
//   }


//   // CREATE user

// Future<void> saveUser(UserModel user) async {
//   String? uploadedImageUrl;

//   // Upload image to Cloudinary if available
//   if (_imagePath != null && _imagePath!.isNotEmpty) {
//     uploadedImageUrl = await uploadImageToCloudinary(_imagePath!);
//   }

//   final updatedUser = user.copyWith(
//     profilePhoto: uploadedImageUrl ?? user.profilePhoto,
//     gender: _gender ?? user.gender,
//   );

//   await _userService.createOrUpdateUser(updatedUser);
//   _currentUser = updatedUser;
//   notifyListeners();
// }


//   // UPDATE user
//   Future<void> updateUser(Map<String, dynamic> updates) async {
//     if (_currentUser == null) return;

//     updates['profilePhoto'] = _imagePath ?? updates['profilePhoto'];
//     updates['gender'] = _gender ?? updates['gender'];

//     await _userService.updateUser(_currentUser!.userId, updates);

//     _currentUser = _currentUser!.copyWith(
//       profilePhoto: updates['profilePhoto'],
//       name: updates['name'] ?? _currentUser!.name,
//       gender: updates['gender'],
//       phoneNumber: updates['phoneNumber'] ?? _currentUser!.phoneNumber,
//       email: updates['email'] ?? _currentUser!.email,
//     );
//     notifyListeners();
//   }

//   // DELETE user
//   Future<void> deleteUser() async {
//     if (_currentUser == null) return;
//     await _userService.deleteUser(_currentUser!.userId);
//     _currentUser = null;
//     _gender = null;
//     _imagePath = null;
//     _isApproved = null;
//     _approvalStatus = null;
//     notifyListeners();
//   }

//   // CHECK if user is already registered
//   Future<String?> checkUserRegistration() async {
//     final registeredUserId = await _userService.checkUserRegistration();
//     if (registeredUserId != null) {
//       userId = registeredUserId;
//       await fetchUser(userId!); 
//     }
//     return registeredUserId;
//   }

//   // CHECK if current user is approved
//   Future<bool> checkUserApproval() async {
//     _isApproved = await _userService.isUserApproved();
//     notifyListeners();
//     return _isApproved ?? false;
//   }

// //   Future<void> refreshApprovalStatus() async {
// //     _isApproved = await _userService.isUserApproved();
// //     _approvalStatus = await _userService.getUserApprovalStatus();
// //     notifyListeners();
// // }


// Future<void> refreshApprovalStatus() async {
//   _isCheckingApproval = true;
//   notifyListeners();

//   try {
//     _isApproved = await _userService.isUserApproved();
//     _approvalStatus = await _userService.getUserApprovalStatus();
//   } catch (e) {
//     _approvalStatus = "error";
//   }

//   _isCheckingApproval = false;
//   notifyListeners();
// }


//   void clearAllData() {
//     _currentUser = null;
//     userId = null;
//     _isApproved = null;
//     _approvalStatus = null;
//     _gender = null;
//     _imagePath = null;
//     _identityImagePath = null;
//     notifyListeners();
//   }


// Future<String?> uploadImageToCloudinary(String imagePath) async {
//   final cloudinary = CloudinaryPublic(
//     'dq4gjskwm', 
//     'user_profile_image',
//     cache: false,
//   );

//   try {
//     CloudinaryResponse response = await cloudinary.uploadFile(
//       CloudinaryFile.fromFile(
//         imagePath,
//         resourceType: CloudinaryResourceType.Image,
//       ),
//     );
//     return response.secureUrl; // ✅ This URL will be stored in Firestore
//   } catch (e) {
//     debugPrint("Cloudinary upload error: $e");
//     return null;
//   }
// }


// }


import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/model/user_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';

class ServiceProvider extends ChangeNotifier {
  final UserFirebaseService _userService = UserFirebaseService();

  UserModel? _currentUser;
  String? userId;
  bool? _isApproved;
  String? _approvalStatus;

  String? _gender;
  String? _imagePath;
  String? _identityImagePath;
  String? _experienceCertificatePath;
  bool _isCheckingApproval = false;
  
  // Loading states for uploads
  bool _isUploadingIdCard = false;
  bool _isUploadingExperienceCert = false;
  bool _isUploadingProfile = false;

  UserModel? get currentUser => _currentUser;
  String? get imagePath => _imagePath;
  String? get gender => _gender;
  String? get identityImagePath => _identityImagePath;
  String? get experienceCertificatePath => _experienceCertificatePath;
  bool? get isApproved => _isApproved;
  String? get approvalStatus => _approvalStatus;
  bool get isCheckingApproval => _isCheckingApproval;
  bool get isUploadingIdCard => _isUploadingIdCard;
  bool get isUploadingExperienceCert => _isUploadingExperienceCert;
  bool get isUploadingProfile => _isUploadingProfile;

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

  void setIdentityImage(String path) {
    _identityImagePath = path;
    notifyListeners();
  }

  void clearIdentityImage() {
    _identityImagePath = null;
    notifyListeners();
  }

  void setExperienceCertificate(String path) {
    _experienceCertificatePath = path;
    notifyListeners();
  }

  void clearExperienceCertificate() {
    _experienceCertificatePath = null;
    notifyListeners();
  }

  // READ user
  Future<void> fetchUser(String userId) async {
    _currentUser = await _userService.getUser(userId);

    // Sync UI state with fetched user data
    if (_currentUser != null) {
      _gender = _currentUser!.gender;
      _imagePath = _currentUser!.profilePhoto;
      _identityImagePath = _currentUser!.idCardPhoto;
      _experienceCertificatePath = _currentUser!.experienceCertificate;
    }
    notifyListeners();
  }

  // CREATE user
  Future<void> saveUser(UserModel user) async {
    String? uploadedProfileUrl;
    String? uploadedIdCardUrl;
    String? uploadedExperienceCertUrl;

    // Upload profile image to Cloudinary if available
    if (_imagePath != null && _imagePath!.isNotEmpty) {
      _isUploadingProfile = true;
      notifyListeners();
      uploadedProfileUrl = await uploadImageToCloudinary(_imagePath!);
      _isUploadingProfile = false;
      notifyListeners();
    }

    // Upload ID card to Cloudinary if available
    if (_identityImagePath != null && _identityImagePath!.isNotEmpty) {
      _isUploadingIdCard = true;
      notifyListeners();
      uploadedIdCardUrl = await uploadImageToCloudinary(_identityImagePath!);
      _isUploadingIdCard = false;
      notifyListeners();
    }

    // Upload experience certificate to Cloudinary if available
    if (_experienceCertificatePath != null && _experienceCertificatePath!.isNotEmpty) {
      _isUploadingExperienceCert = true;
      notifyListeners();
      uploadedExperienceCertUrl = await uploadImageToCloudinary(_experienceCertificatePath!);
      _isUploadingExperienceCert = false;
      notifyListeners();
    }

    final updatedUser = user.copyWith(
      profilePhoto: uploadedProfileUrl ?? user.profilePhoto,
      gender: _gender ?? user.gender,
      idCardPhoto: uploadedIdCardUrl ?? user.idCardPhoto,
      experienceCertificate: uploadedExperienceCertUrl ?? user.experienceCertificate,
    );

    await _userService.createOrUpdateUser(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }

  // UPDATE user
  Future<void> updateUser(Map<String, dynamic> updates) async {
    if (_currentUser == null) return;

    // Upload new images if paths have changed
    if (_imagePath != null && _imagePath != _currentUser!.profilePhoto) {
      final uploadedUrl = await uploadImageToCloudinary(_imagePath!);
      if (uploadedUrl != null) {
        updates['profilePhoto'] = uploadedUrl;
      }
    }

    if (_identityImagePath != null && _identityImagePath != _currentUser!.idCardPhoto) {
      final uploadedUrl = await uploadImageToCloudinary(_identityImagePath!);
      if (uploadedUrl != null) {
        updates['idCardPhoto'] = uploadedUrl;
      }
    }

    if (_experienceCertificatePath != null && 
        _experienceCertificatePath != _currentUser!.experienceCertificate) {
      final uploadedUrl = await uploadImageToCloudinary(_experienceCertificatePath!);
      if (uploadedUrl != null) {
        updates['experienceCertificate'] = uploadedUrl;
      }
    }

    await _userService.updateUser(_currentUser!.userId, updates);

    // Update current user with new data
    _currentUser = _currentUser!.copyWith(
      profilePhoto: updates['profilePhoto'] as String?,
      name: updates['name'] as String?,
      gender: updates['gender'] as String?,
      phoneNumber: updates['phoneNumber'] as String?,
      email: updates['email'] as String?,
      location: updates['location'] as String?,
      idCardPhoto: updates['idCardPhoto'] as String?,
      experienceCertificate: updates['experienceCertificate'] as String?,
      yearsOfexperience: updates['yearsOfexperience'] as String?,
      selectService: updates['selectService'] as String?,
      status: updates['status'] as String?,
      firstHourPrice: updates['firstHourPrice'] as String?,
      bankAccountNumber: updates['bankAccountNumber'] as String?,
      bankIfscCode: updates['bankIfscCode'] as String?,
      bankName: updates['bankName'] as String?,
      accountHolderName: updates['accountHolderName'] as String?,
      upiId: updates['upiId'] as String?,
      businessName: updates['businessName'] as String?,
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
    _identityImagePath = null;
    _experienceCertificatePath = null;
    _isApproved = null;
    _approvalStatus = null;
    notifyListeners();
  }

  // CHECK if user is already registered
  Future<String?> checkUserRegistration() async {
    final registeredUserId = await _userService.checkUserRegistration();
    if (registeredUserId != null) {
      userId = registeredUserId;
      await fetchUser(userId!);
    }
    return registeredUserId;
  }

  // CHECK if current user is approved
  Future<bool> checkUserApproval() async {
    _isApproved = await _userService.isUserApproved();
    notifyListeners();
    return _isApproved ?? false;
  }

  Future<void> refreshApprovalStatus() async {
    _isCheckingApproval = true;
    notifyListeners();

    try {
      _isApproved = await _userService.isUserApproved();
      _approvalStatus = await _userService.getUserApprovalStatus();
    } catch (e) {
      _approvalStatus = "error";
    }

    _isCheckingApproval = false;
    notifyListeners();
  }

  void clearAllData() {
    _currentUser = null;
    userId = null;
    _isApproved = null;
    _approvalStatus = null;
    _gender = null;
    _imagePath = null;
    _identityImagePath = null;
    _experienceCertificatePath = null;
    notifyListeners();
  }

  Future<String?> uploadImageToCloudinary(String imagePath) async {
    final cloudinary = CloudinaryPublic(
      'dq4gjskwm',
      'user_profile_image',
      cache: false,
    );

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      debugPrint("Cloudinary upload error: $e");
      return null;
    }
  }
}