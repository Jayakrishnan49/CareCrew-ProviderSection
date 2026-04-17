// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';

// class BookingRequestService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Changed to 'booking_requests' (plural)
//   Stream<List<BookingRequest>> getProviderBookingRequests(String providerId) {
//     return _firestore
//         .collection('service_provider')
//         .doc(providerId)  
//         // .where('providerId', isEqualTo: providerId)
//         .collection('booking_requests')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data();
//         data['id'] = doc.id;
//         return BookingRequest.fromMap(data);
//       }).toList()
//         ..sort((a, b) => b.createdAt.compareTo(a.createdAt)); // Sort by newest first
//     });
//   }

//   //  Get requests by status 
//   Stream<List<BookingRequest>> getBookingRequestsByStatus(
//     String providerId,
//     String status,
//   ) {
//     return _firestore
//         .collection('service_provider')
//         .doc(providerId)
//         .collection('booking_requests')  
//         // .where('providerId', isEqualTo: providerId)
//         .where('status', isEqualTo: status)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data();
//         data['id'] = doc.id;
//         return BookingRequest.fromMap(data);
//       }).toList()
//         ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     });
//   }

//   // Update in BOTH locations 
//   Future<void> updateBookingStatus({
//     required String userId,
//     required String providerId,  
//     required String requestId,
//     required String status,
//     required DateTime requestSentAt,
//   }) async {
//     try {
//       final now = DateTime.now();
//       final responseTimeMinutes = now.difference(requestSentAt).inMinutes;

//       final updateData = {
//         'status': status,
//         'responseAt': Timestamp.fromDate(now),
//         'responseTimeMinutes': responseTimeMinutes,
//         'updatedAt': FieldValue.serverTimestamp(),
//       };

//       // Update in provider's subcollection
//       await _firestore
//           .collection('service_provider')
//           .doc(providerId)  
//           .collection('booking_requests')  
//           .doc(requestId)
//           .update(updateData);

//       // Update in user's booking collection
//       await _firestore
//           .collection('users')
//           .doc(userId)  
//           .collection('my_bookings')  
//           .doc(requestId)
//           .update(updateData);

//       print('Updated booking in both locations');
//     } catch (e) {
//       print('Error updating booking: $e');
//       throw Exception('Failed to update booking status: $e');
//     }
//   }

//   // Accept with providerId 
//   Future<void> acceptBookingRequest({
//     required String userId,
//     required String providerId,  
//     required String requestId,
//     required DateTime requestSentAt,
//   }) async {
//     await updateBookingStatus(
//       userId: userId,
//       providerId: providerId,  
//       requestId: requestId,
//       status: 'accepted',
//       requestSentAt: requestSentAt,
//     );
//   }

//   // Reject with providerId 
//   Future<void> rejectBookingRequest({
//     required String userId,
//     required String providerId, 
//     required String requestId,
//     required DateTime requestSentAt,
//     String? rejectionReason,  
//   }) async {
//     await updateBookingStatus(
//       userId: userId,
//       providerId: providerId,  
//       requestId: requestId,
//       status: 'rejected',
//       requestSentAt: requestSentAt,
//     );

//     // Optionally save rejection reason
//     if (rejectionReason != null && rejectionReason.isNotEmpty) {
//       final reasonData = {'rejectionReason': rejectionReason};
      
//       await _firestore
//           .collection('service_provider')
//           .doc(providerId)
//           .collection('booking_requests')
//           .doc(requestId)
//           .update(reasonData);

//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('my_bookings')
//           .doc(requestId)
//           .update(reasonData);
//     }
//   }

//   // Get single booking 
//   Future<BookingRequest?> getBookingRequestById({
//     required String providerId,  
//     required String requestId,
//   }) async {
//     try {
//       DocumentSnapshot doc = await _firestore
//           .collection('service_provider')
//           .doc(providerId)  
//           .collection('booking_requests')  
//           .doc(requestId)
//           .get();

//       if (doc.exists) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         data['id'] = doc.id;
//         return BookingRequest.fromMap(data);
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to get booking request: $e');
//     }
//   }

//   // Pending count 
//   Stream<int> getPendingRequestsCount(String providerId) {
//     return _firestore
//         .collectionGroup('booking_requests')  
//         .where('providerId', isEqualTo: providerId)
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .map((snapshot) => snapshot.docs.length);
//   }


//    // Mark booking as completed 
//   Future<void> completeBookingRequest({
//     required String userId,
//     required String providerId,
//     required String requestId,
//   }) async {
//     try {
//       final updateData = {
//         'status': 'completed',
//         'completedAt': Timestamp.now(),
//         'updatedAt': FieldValue.serverTimestamp(),
//       };

//       // Update in provider's collection
//       await _firestore
//           .collection('service_provider')
//           .doc(providerId)
//           .collection('booking_requests')
//           .doc(requestId)
//           .update(updateData);

//       // Update in user's collection
//       await _firestore
//           .collection('users')
//           .doc(userId)
//           .collection('my_bookings')
//           .doc(requestId)
//           .update(updateData);

//       print('Booking marked as completed');
//     } catch (e) {
//       print('Error completing booking: $e');
//       throw Exception('Failed to complete booking: $e');
//     }
//   }


   
//   Future<Map<String, int>> getBookingStatistics(String providerId) async {
//     try {
//       final snapshot = await _firestore
//           .collection('service_provider')
//           .doc(providerId)
//           .collection('booking_requests')
//           .get();

//       int pending = 0;
//       int accepted = 0;
//       int rejected = 0;
//       int completed = 0;

//       for (var doc in snapshot.docs) {
//         final status = doc.data()['status'] as String;
//         switch (status) {
//           case 'pending':
//             pending++;
//             break;
//           case 'accepted':
//             accepted++;
//             break;
//           case 'rejected':
//             rejected++;
//             break;
//           case 'completed':
//             completed++;
//             break;
//         }
//       }

//       return {
//         'pending': pending,
//         'accepted': accepted,
//         'rejected': rejected,
//         'completed': completed,
//         'total': snapshot.docs.length,
//       };
//     } catch (e) {
//       throw Exception('Failed to get booking statistics: $e');
//     }
//   }

// }






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_2_provider/model/booking_request_model.dart';

class BookingRequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get provider booking requests stream
  Stream<List<BookingRequest>> getProviderBookingRequests(String providerId) {
    return _firestore
        .collection('service_provider')
        .doc(providerId)
        .collection('booking_requests')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return BookingRequest.fromMap(data);
      }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  // Get requests by status
  Stream<List<BookingRequest>> getBookingRequestsByStatus(
    String providerId,
    String status,
  ) {
    return _firestore
        .collection('service_provider')
        .doc(providerId)
        .collection('booking_requests')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return BookingRequest.fromMap(data);
      }).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  // ✅ NEW: Update provider's average response time in main collection
  Future<void> _updateProviderAverageResponseTime({
    required String providerId,
    required int newResponseTimeMinutes,
  }) async {
    try {
      final providerRef = _firestore.collection('service_provider').doc(providerId);
      final providerDoc = await providerRef.get();

      if (!providerDoc.exists) {
        print('⚠️ Provider document not found: $providerId');
        return;
      }

      final data = providerDoc.data()!;
      final currentAverage = (data['averageResponseTimeMinutes'] ?? 0.0).toDouble();
      final totalResponses = (data['totalResponses'] ?? 0) as int;

      // Calculate new average
      // Formula: ((old_average * old_count) + new_value) / (old_count + 1)
      final newAverage = totalResponses == 0
          ? newResponseTimeMinutes.toDouble()
          : ((currentAverage * totalResponses) + newResponseTimeMinutes) / (totalResponses + 1);

      print('📊 Updating provider response stats:');
      print('Provider ID: $providerId');
      print('Current average: $currentAverage minutes');
      print('Total responses: $totalResponses');
      print('New response time: $newResponseTimeMinutes minutes');
      print('New average: ${newAverage.toStringAsFixed(1)} minutes');
      print('New total: ${totalResponses + 1}');

      // Update provider document in main collection
      await providerRef.update({
        'averageResponseTimeMinutes': newAverage,
        'totalResponses': totalResponses + 1,
        'lastResponseAt': Timestamp.now(),
      });

      print('✅ Provider average updated successfully!');
    } catch (e) {
      print('❌ Error updating average: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }

  // Update booking status in both locations
  Future<void> updateBookingStatus({
    required String userId,
    required String providerId,
    required String requestId,
    required String status,
    required DateTime requestSentAt,
  }) async {
    try {
      final now = DateTime.now();
      final responseTimeMinutes = now.difference(requestSentAt).inMinutes;

      final updateData = {
        'status': status,
        'responseAt': Timestamp.fromDate(now),
        'responseTimeMinutes': responseTimeMinutes,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Update in provider's subcollection
      await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(requestId)
          .update(updateData);

      // Update in user's booking collection
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_bookings')
          .doc(requestId)
          .update(updateData);

      // ✅ NEW: Update provider's average response time in main collection
      await _updateProviderAverageResponseTime(
        providerId: providerId,
        newResponseTimeMinutes: responseTimeMinutes,
      );

      print('✅ Updated booking in both locations and updated provider stats');
    } catch (e) {
      print('❌ Error updating booking: $e');
      throw Exception('Failed to update booking status: $e');
    }
  }

  // Accept booking request
  Future<void> acceptBookingRequest({
    required String userId,
    required String providerId,
    required String requestId,
    required DateTime requestSentAt,
  }) async {
    await updateBookingStatus(
      userId: userId,
      providerId: providerId,
      requestId: requestId,
      status: 'accepted',
      requestSentAt: requestSentAt,
    );
  }

  // Reject booking request
  Future<void> rejectBookingRequest({
    required String userId,
    required String providerId,
    required String requestId,
    required DateTime requestSentAt,
    String? rejectionReason,
  }) async {
    await updateBookingStatus(
      userId: userId,
      providerId: providerId,
      requestId: requestId,
      status: 'rejected',
      requestSentAt: requestSentAt,
    );

    // Optionally save rejection reason
    if (rejectionReason != null && rejectionReason.isNotEmpty) {
      final reasonData = {'rejectionReason': rejectionReason};

      await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(requestId)
          .update(reasonData);

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_bookings')
          .doc(requestId)
          .update(reasonData);
    }
  }

  // Get single booking
  Future<BookingRequest?> getBookingRequestById({
    required String providerId,
    required String requestId,
  }) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(requestId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return BookingRequest.fromMap(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get booking request: $e');
    }
  }

  // Get pending requests count
  Stream<int> getPendingRequestsCount(String providerId) {
    return _firestore
        .collectionGroup('booking_requests')
        .where('providerId', isEqualTo: providerId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  // Mark booking as completed
  Future<void> completeBookingRequest({
    required String userId,
    required String providerId,
    required String requestId,
  }) async {
    try {
      final updateData = {
        'status': 'completed',
        'completedAt': Timestamp.now(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Update in provider's collection
      await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .doc(requestId)
          .update(updateData);

      // Update in user's collection
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('my_bookings')
          .doc(requestId)
          .update(updateData);

      print('✅ Booking marked as completed');
    } catch (e) {
      print('❌ Error completing booking: $e');
      throw Exception('Failed to complete booking: $e');
    }
  }

  // Get booking statistics
  Future<Map<String, int>> getBookingStatistics(String providerId) async {
    try {
      final snapshot = await _firestore
          .collection('service_provider')
          .doc(providerId)
          .collection('booking_requests')
          .get();

      int pending = 0;
      int accepted = 0;
      int rejected = 0;
      int completed = 0;

      for (var doc in snapshot.docs) {
        final status = doc.data()['status'] as String;
        switch (status) {
          case 'pending':
            pending++;
            break;
          case 'accepted':
            accepted++;
            break;
          case 'rejected':
            rejected++;
            break;
          case 'completed':
            completed++;
            break;
        }
      }

      return {
        'pending': pending,
        'accepted': accepted,
        'rejected': rejected,
        'completed': completed,
        'total': snapshot.docs.length,
      };
    } catch (e) {
      throw Exception('Failed to get booking statistics: $e');
    }
  }


//   // ✅ ADD THESE METHODS TO YOUR EXISTING BookingRequestService CLASS

// // Start work timer
// Future<void> startWorkTimer({
//   required String userId,
//   required String providerId,
//   required String requestId,
//   required double firstHourCharge,
//   required double perHourCharge,
// }) async {
//   try {
//     final now = DateTime.now();
//     final updateData = {
//       'workStartTime': Timestamp.fromDate(now),
//       'workEndTime': null,
//       'totalWorkHours': null,
//       'extraCharges': null,
//       'firstHourCharge': firstHourCharge,
//       'perHourCharge': perHourCharge,
//       'updatedAt': FieldValue.serverTimestamp(),
//     };

//     // Update in provider's collection
//     await _firestore
//         .collection('service_provider')
//         .doc(providerId)
//         .collection('booking_requests')
//         .doc(requestId)
//         .update(updateData);

//     // Update in user's collection
//     await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('my_bookings')
//         .doc(requestId)
//         .update(updateData);

//     print('✅ Work timer started at: $now');
//   } catch (e) {
//     print('❌ Error starting work timer: $e');
//     throw Exception('Failed to start work timer: $e');
//   }
// }

// // Stop work timer and calculate charges
// Future<Map<String, dynamic>> stopWorkTimer({
//   required String userId,
//   required String providerId,
//   required String requestId,
//   required DateTime workStartTime,
//   required double firstHourCharge,
//   required double perHourCharge,
// }) async {
//   try {
//     final now = DateTime.now();
//     final duration = now.difference(workStartTime);
//     final totalHours = duration.inMinutes / 60.0;
    
//     // Calculate extra charges
//     double extraCharges = 0.0;
//     if (totalHours > 1.0) {
//       final extraHours = totalHours - 1.0;
//       extraCharges = extraHours * perHourCharge;
//     }

//     final updateData = {
//       'workEndTime': Timestamp.fromDate(now),
//       'totalWorkHours': totalHours,
//       'extraCharges': extraCharges,
//       'updatedAt': FieldValue.serverTimestamp(),
//     };

//     // Update in provider's collection
//     await _firestore
//         .collection('service_provider')
//         .doc(providerId)
//         .collection('booking_requests')
//         .doc(requestId)
//         .update(updateData);

//     // Update in user's collection
//     await _firestore
//         .collection('users')
//         .doc(userId)
//         .collection('my_bookings')
//         .doc(requestId)
//         .update(updateData);

//     print('✅ Work timer stopped. Duration: ${totalHours.toStringAsFixed(2)} hours');
//     print('💰 Extra charges: ₹${extraCharges.toStringAsFixed(2)}');

//     return {
//       'totalHours': totalHours,
//       'extraCharges': extraCharges,
//       'totalAmount': firstHourCharge + extraCharges,
//     };
//   } catch (e) {
//     print('❌ Error stopping work timer: $e');
//     throw Exception('Failed to stop work timer: $e');
//   }
// }




// ✅ REPLACE YOUR EXISTING METHODS WITH THESE SIMPLIFIED VERSIONS

// Start work timer (simplified)
Future<void> startWorkTimer({
  required String userId,
  required String providerId,
  required String requestId,
}) async {
  try {
    final now = DateTime.now();
    final updateData = {
      'workStartTime': Timestamp.fromDate(now),
      'workEndTime': null,
      'totalWorkHours': null,
      'extraCharges': null,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Update in provider's collection
    await _firestore
        .collection('service_provider')
        .doc(providerId)
        .collection('booking_requests')
        .doc(requestId)
        .update(updateData);

    // Update in user's collection
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('my_bookings')
        .doc(requestId)
        .update(updateData);

    print('✅ Work timer started at: $now');
  } catch (e) {
    print('❌ Error starting work timer: $e');
    throw Exception('Failed to start work timer: $e');
  }
}

// Stop work timer and calculate charges (₹200/hr after first hour)
Future<Map<String, dynamic>> stopWorkTimer({
  required String userId,
  required String providerId,
  required String requestId,
  required DateTime workStartTime,
  required double firstHourCharge,
}) async {
  try {
    final now = DateTime.now();
    final duration = now.difference(workStartTime);
    final totalHours = duration.inMinutes / 60.0;
    
    // Calculate extra charges - ₹200 per hour after first hour
    double extraCharges = 0.0;
    if (totalHours > 1.0) {
      final extraHours = totalHours - 1.0;
      extraCharges = extraHours * 200; // ✅ Fixed ₹200/hr
    }

    final updateData = {
      'workEndTime': Timestamp.fromDate(now),
      'totalWorkHours': totalHours,
      'extraCharges': extraCharges,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    // Update in provider's collection
    await _firestore
        .collection('service_provider')
        .doc(providerId)
        .collection('booking_requests')
        .doc(requestId)
        .update(updateData);

    // Update in user's collection
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('my_bookings')
        .doc(requestId)
        .update(updateData);

    print('✅ Work timer stopped. Duration: ${totalHours.toStringAsFixed(2)} hours');
    print('💰 Extra charges: ₹${extraCharges.toStringAsFixed(2)}');

    return {
      'totalHours': totalHours,
      'extraCharges': extraCharges,
      'totalAmount': firstHourCharge + extraCharges,
    };
  } catch (e) {
    print('❌ Error stopping work timer: $e');
    throw Exception('Failed to stop work timer: $e');
  }
}


// Real-time stream for a single booking request
Stream<BookingRequest?> getBookingRequestStream({
  required String providerId,
  required String requestId,
}) {
  return _firestore
      .collection('service_provider')
      .doc(providerId)
      .collection('booking_requests')
      .doc(requestId)
      .snapshots()
      .map((doc) {
        if (!doc.exists) return null;
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return BookingRequest.fromMap(data);
      });
}

}