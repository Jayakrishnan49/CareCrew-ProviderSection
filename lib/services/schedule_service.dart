import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2_provider/model/booking_request_model.dart';

class ScheduleService {
  Stream<List<BookingRequest>> getBookingsForDay(DateTime selectedDay) {
    final startOfDay = DateTime(
        selectedDay.year, selectedDay.month, selectedDay.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return FirebaseFirestore.instance
        .collection('service_provider')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('booking_requests')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookingRequest.fromMap(doc.data()))
            .toList());
  }
}