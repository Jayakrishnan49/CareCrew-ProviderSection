import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRequest {
  final String id;
  final String userId;
  final String userName;
  final String userProfileImage;  // ✅ Nullable
  final String userPhone;
  final String userEmail;
  final String providerId;
  final String providerName;
  final String serviceType;
  final DateTime date;
  final String time;
  final String address;
  final String notes;
  final List<String> imageUrls;
  final String status; 
  final DateTime createdAt;
  final double price;
  final DateTime requestSentAt;    
  final DateTime? responseAt;        
  final int? responseTimeMinutes;
    // ✅ NEW: Work timer fields
  final DateTime? workStartTime;
  final DateTime? workEndTime;
  final double? totalWorkHours;
  final double? extraCharges;
  // final double? firstHourCharge;  
  final String? paymentStatus;
  final String? paymentId;
  final DateTime? completedAt;

  BookingRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImage,  
    required this.userPhone,
    required this.userEmail,
    required this.providerId,
    required this.providerName,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.address,
    required this.notes,
    required this.imageUrls,
    required this.status,
    required this.createdAt,
    required this.price,
    required this.requestSentAt,
    this.responseAt,
    this.responseTimeMinutes,
    this.workStartTime,
    this.workEndTime,
    this.totalWorkHours,
    this.extraCharges,
    // this.firstHourCharge,
    this.paymentStatus,
    this.paymentId,
    this.completedAt,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage, 
      'userPhone': userPhone,
      'userEmail': userEmail,
      'providerId': providerId,
      'providerName': providerName,
      'serviceType': serviceType,
      'date': Timestamp.fromDate(date),
      'time': time,
      'address': address,
      'notes': notes,
      'imageUrls': imageUrls,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'price': price,
      'requestSentAt': Timestamp.fromDate(requestSentAt),
      'responseAt': responseAt != null ? Timestamp.fromDate(responseAt!) : null,
      'responseTimeMinutes': responseTimeMinutes,
      'workStartTime': workStartTime != null ? Timestamp.fromDate(workStartTime!) : null,
      'workEndTime': workEndTime != null ? Timestamp.fromDate(workEndTime!) : null,
      'totalWorkHours': totalWorkHours,
      'extraCharges': extraCharges,
      // 'firstHourCharge': firstHourCharge,
      // 'perHourCharge': perHourCharge,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  factory BookingRequest.fromMap(Map<String, dynamic> map) {
    return BookingRequest(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userProfileImage: map['userProfileImage'],  
      userPhone: map['userPhone'] ?? '',
      userEmail: map['userEmail'] ?? '',
      providerId: map['providerId'] ?? '',
      providerName: map['providerName'] ?? '',
      serviceType: map['serviceType'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'] ?? '',
      address: map['address'] ?? '',
      notes: map['notes'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      status: map['status'] ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      price: (map['price'] ?? 0).toDouble(),
      requestSentAt: (map['requestSentAt'] as Timestamp).toDate(),
      responseAt: map['responseAt'] != null 
          ? (map['responseAt'] as Timestamp).toDate() 
          : null,
      responseTimeMinutes: map['responseTimeMinutes'],
       workStartTime: map['workStartTime'] != null
          ? (map['workStartTime'] as Timestamp).toDate()
          : null,
      workEndTime: map['workEndTime'] != null
          ? (map['workEndTime'] as Timestamp).toDate()
          : null,
      totalWorkHours: map['totalWorkHours']?.toDouble(),
      extraCharges: map['extraCharges']?.toDouble(),
      // firstHourCharge: map['firstHourCharge']?.toDouble() ?? 0.0,
      // perHourCharge: map['perHourCharge']?.toDouble() ?? 0.0,
      paymentStatus: map['paymentStatus'],
      paymentId: map['paymentId'],
      completedAt: map['completedAt'] != null
    ? (map['completedAt'] as Timestamp).toDate()
    : null,
    );
  }
}