// class UserModel {
//   final String userId;
//   final String profilePhoto;
//   final String name;
//   final String gender;
//   final String phoneNumber;
//   final String location;
//   final String email;
//   final String idCardPhoto;
//   final String experienceCertificate;
//   final String yearsOfexperience;
//   final String selectService;
//   final String status;

//   UserModel({
//     required this.userId,
//     required this.profilePhoto,
//     required this.name,
//     required this.gender,
//     required this.phoneNumber,
//     required this.location,
//     required this.email,
//     required this.idCardPhoto,
//     required this.experienceCertificate,
//     required this.yearsOfexperience,
//     required this.selectService,
//     required this.status,
//   });

//   // Convert from JSON
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       userId: json['userId'] ?? '',
//       profilePhoto: json['profilePhoto'] ?? '',
//       name: json['name'] ?? '',
//       gender: json['gender'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       location: json['location']??'',
//       email: json['email'] ?? '',
//       idCardPhoto: json['idCardPhoto'] ?? '',
//       experienceCertificate: json['experienceCertificate'] ?? '',
//       yearsOfexperience: json['yearsOfexperience'] ?? '',
//       selectService: json['selectService'] ?? '',
//       status: json['status'] ?? '',
//     );
//   }

//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'profilePhoto': profilePhoto, 
//       'name': name,
//       'gender': gender,
//       'phoneNumber': phoneNumber,
//       'location':location,
//       'email': email,
//       'idCardPhoto': idCardPhoto,
//       'experienceCertificate': experienceCertificate,
//       'yearsOfexperience': yearsOfexperience,
//       'selectService': selectService,
//       'status': status,
//     };
//   }

//   UserModel copyWith({
//     String? userId,
//     String? profilePhoto,
//     String? name,
//     String? gender,
//     String? phoneNumber,
//     String? email,
//     String? idCardPhoto,
//     String? experienceCertificate,
//     String? yearsOfexperience,
//     String? selectService,
//     String? status,
//   }) {
//     return UserModel(
//       userId: userId ?? this.userId,
//       profilePhoto: profilePhoto ?? this.profilePhoto,
//       name: name ?? this.name,
//       gender: gender ?? this.gender,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       location: location??this.location,
//       email: email ?? this.email,
//       idCardPhoto: idCardPhoto ?? this.idCardPhoto,
//       experienceCertificate: experienceCertificate ?? this.experienceCertificate,
//       yearsOfexperience: yearsOfexperience ?? this.yearsOfexperience,
//       selectService: selectService ?? this.selectService,
//       status: status ?? this.status, 
//     );
//   }
// }


///////////////     service provider app        ////////////////////
class UserModel {
  final String userId;
  final String profilePhoto;
  final String name;
  final String gender;
  final String phoneNumber;
  final String location;
  final String email;
  final String idCardPhoto;
  final String experienceCertificate;
  final String yearsOfexperience;
  final String selectService;
  final String status;
  final String firstHourPrice;
  final String bankAccountNumber;
  final String bankIfscCode;
  final String bankName;
  final String accountHolderName;
  
  // Added fields
  final String upiId;
  final String businessName;

  UserModel({
    required this.userId,
    required this.profilePhoto,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.location,
    required this.email,
    required this.idCardPhoto,
    required this.experienceCertificate,
    required this.yearsOfexperience,
    required this.selectService,
    required this.status,
    required this.firstHourPrice,
    required this.bankAccountNumber,
    required this.bankIfscCode,
    required this.bankName,
    required this.accountHolderName,
    required this.upiId,
    required this.businessName,
  });

  // Convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: json['location'] ?? '',
      email: json['email'] ?? '',
      idCardPhoto: json['idCardPhoto'] ?? '',
      experienceCertificate: json['experienceCertificate'] ?? '',
      yearsOfexperience: json['yearsOfexperience'] ?? '',
      selectService: json['selectService'] ?? '',
      status: json['status'] ?? '',
      firstHourPrice: json['firstHourPrice'] ?? '',
      bankAccountNumber: json['bankAccountNumber'] ?? '',
      bankIfscCode: json['bankIfscCode'] ?? '',
      bankName: json['bankName'] ?? '',
      accountHolderName: json['accountHolderName'] ?? '',
      upiId: json['upiId'] ?? '',
      businessName: json['businessName'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'profilePhoto': profilePhoto,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'location': location,
      'email': email,
      'idCardPhoto': idCardPhoto,
      'experienceCertificate': experienceCertificate,
      'yearsOfexperience': yearsOfexperience,
      'selectService': selectService,
      'status': status,
      'firstHourPrice': firstHourPrice,
      'bankAccountNumber': bankAccountNumber,
      'bankIfscCode': bankIfscCode,
      'bankName': bankName,
      'accountHolderName': accountHolderName,
      'upiId': upiId,
      'businessName': businessName,
    };
  }

  UserModel copyWith({
    String? userId,
    String? profilePhoto,
    String? name,
    String? gender,
    String? phoneNumber,
    String? location,
    String? email,
    String? idCardPhoto,
    String? experienceCertificate,
    String? yearsOfexperience,
    String? selectService,
    String? status,
    String? firstHourPrice,
    String? bankAccountNumber,
    String? bankIfscCode,
    String? bankName,
    String? accountHolderName,
    String? upiId,
    String? businessName,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      email: email ?? this.email,
      idCardPhoto: idCardPhoto ?? this.idCardPhoto,
      experienceCertificate: experienceCertificate ?? this.experienceCertificate,
      yearsOfexperience: yearsOfexperience ?? this.yearsOfexperience,
      selectService: selectService ?? this.selectService,
      status: status ?? this.status,
      firstHourPrice: firstHourPrice ?? this.firstHourPrice,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankIfscCode: bankIfscCode ?? this.bankIfscCode,
      bankName: bankName ?? this.bankName,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      upiId: upiId ?? this.upiId,
      businessName: businessName ?? this.businessName,
    );
  }
}