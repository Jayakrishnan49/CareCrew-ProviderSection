import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2_provider/model/user_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';

class HomeProvider extends ChangeNotifier {
  final UserFirebaseService _userService = UserFirebaseService();
  final String providerId = FirebaseAuth.instance.currentUser?.uid ?? '';

  // ── User ──────────────────────────────────────────────────────────────────
  Stream<UserModel?> get userStream => _userService.streamUser(providerId);

  // ── Streams (expose directly — widgets subscribe via StreamBuilder) ────────
  Stream<QuerySnapshot> get pendingRequestsStream => FirebaseFirestore.instance
      .collection('service_provider')
      .doc(providerId)
      .collection('booking_requests')
      .where('status', isEqualTo: 'pending')
      .snapshots();

  Stream<QuerySnapshot> get pendingPreviewStream => FirebaseFirestore.instance
      .collection('service_provider')
      .doc(providerId)
      .collection('booking_requests')
      .where('status', isEqualTo: 'pending')
      .limit(3)
      .snapshots();

  Stream<QuerySnapshot> get allBookingsStream => FirebaseFirestore.instance
      .collection('service_provider')
      .doc(providerId)
      .collection('booking_requests')
      .snapshots();

  Stream<QuerySnapshot> get acceptedBookingsStream => FirebaseFirestore.instance
      .collection('service_provider')
      .doc(providerId)
      .collection('booking_requests')
      .where('status', isEqualTo: 'accepted')
      .snapshots();

  // ── Helpers ───────────────────────────────────────────────────────────────
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String getTimeAgo(dynamic timestamp) {
    if (timestamp == null) return 'Just now';
    final dateTime = (timestamp as Timestamp).toDate();
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  /// Filter any booking snapshot to only today's docs
  List<QueryDocumentSnapshot> filterToday(List<QueryDocumentSnapshot> docs) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    return docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['date'] == null) return false;
      final d = (data['date'] as Timestamp).toDate();
      return DateTime(d.year, d.month, d.day).isAtSameMomentAs(todayDate);
    }).toList();
  }

({int active, int completed, double earnings}) todayStats(QuerySnapshot snap) {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);

  int active = 0, completed = 0;
  double earnings = 0;

  for (final doc in snap.docs) {
    final data = doc.data() as Map<String, dynamic>;
    final status = data['status'] ?? '';

    // Active: any accepted job right now (no date filter)
    if (status == 'accepted') active++;

    // Completed + Earnings: only if completed today
    if (status == 'completed' && data['completedAt'] != null) {
      final completedAt = (data['completedAt'] as Timestamp).toDate();
      final completedDate = DateTime(
          completedAt.year, completedAt.month, completedAt.day);

      if (completedDate.isAtSameMomentAs(todayDate)) {
        completed++;
        if (data['paymentStatus'] == 'paid') {
          earnings += (data['price'] ?? 0.0).toDouble() +
              (data['extraCharges'] ?? 0.0).toDouble();
        }
      }
    }
  }

  return (active: active, completed: completed, earnings: earnings);
}

  /// Compute overall performance stats
  ({int total, int accepted, int completed, int acceptanceRate})
      performanceStats(QuerySnapshot snap) {
    final total = snap.docs.length;
    int accepted = 0, completed = 0;
    for (final doc in snap.docs) {
      final status = (doc.data() as Map<String, dynamic>)['status'];
      if (status == 'accepted') accepted++;
      if (status == 'completed') completed++;
    }
    final rate =
        total > 0 ? ((accepted + completed) / total * 100).toInt() : 0;
    return (
      total: total,
      accepted: accepted,
      completed: completed,
      acceptanceRate: rate,
    );
  }
}