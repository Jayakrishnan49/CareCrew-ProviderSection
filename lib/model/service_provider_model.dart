class ServiceModel {
  final String userId;
  final String profilePhoto;
  final String name;
  final String gender;
  final String phoneNumber;
  final String email;
  final String idCardPhoto;
  final String experienceCertificate;
  final String yearsOfexperience;
  final String selectService;
  final String status;

  ServiceModel({
    required this.userId,
    required this.profilePhoto,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.idCardPhoto,
    required this.experienceCertificate,
    required this.yearsOfexperience,
    required this.selectService,
    required this.status,
  });

  //convert from json
  factory ServiceModel.fromJson(Map<String, dynamic>json){
    return ServiceModel(
      userId: json['userId']??'',
      profilePhoto: json['profilePhoto'],
      name: json['name']??'', 
      gender: json['gender']??'', 
      phoneNumber: json['phoneNumber']??'', 
      email: json['email']??'', 
      idCardPhoto: json['idCardPhoto']??'', 
      experienceCertificate: json['experienceCertificate']??'', 
      yearsOfexperience: json['yearsOfexperience']??'', 
      selectService: json['selectService']??'',
      status: json['status']??'',
      );
  }

   // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'profileImage': profilePhoto,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'idCardPhoto':idCardPhoto,
      'experienceCertificate':experienceCertificate,
      'yearsOfexperience':yearsOfexperience,
      'selectService':selectService,
    };
  }

  ServiceModel copyWith({
  String? userId,
  String? profilePhoto,
  String? name,
  String? gender,
  String? phoneNumber,
  String? email,
}) {
  return ServiceModel(
    userId: userId ?? this.userId,
    profilePhoto: profilePhoto ?? this.profilePhoto,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    email: email ?? this.email, 
    idCardPhoto: idCardPhoto, 
    experienceCertificate: '', 
    yearsOfexperience: '', 
    selectService: '',    
    status: '',
  );
}
}