import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/services/booking_request_service.dart';

class BookingRequestProvider extends ChangeNotifier {
  final BookingRequestService _service = BookingRequestService();
  
  // Current tab index
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  // Loading states
  bool _isAccepting = false;
  bool _isRejecting = false;
  bool get isAccepting => _isAccepting;
  bool get isRejecting => _isRejecting;

  // Selected request for actions
  BookingRequest? _selectedRequest;
  BookingRequest? get selectedRequest => _selectedRequest;

  // Timer state
bool _isWorkInProgress = false;
Timer? _workTimer;
Duration _workDuration = Duration.zero;

bool get isWorkInProgress => _isWorkInProgress;
Duration get workDuration => _workDuration;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  void setSelectedRequest(BookingRequest? request) {
    _selectedRequest = request;
    notifyListeners();
  }


  Stream<List<BookingRequest>> getRequestsStreamByStatus(
    String providerId,
    String status,
  ) {
    return _service.getBookingRequestsByStatus(providerId, status);
  }


  Stream<List<BookingRequest>> getRequestsStream(String providerId) {
    switch (_currentTabIndex) {
      case 0: // Pending
        return _service.getBookingRequestsByStatus(providerId, 'pending');
      case 1: // Accepted
        return _service.getBookingRequestsByStatus(providerId, 'accepted');
      case 2: // Rejected
        return _service.getBookingRequestsByStatus(providerId, 'rejected');
      case 3: // Completed
        return _service.getBookingRequestsByStatus(providerId, 'completed');
      default:
        return _service.getProviderBookingRequests(providerId);
    }
  }

  // Accept booking request
  Future<bool> acceptRequest(BookingRequest request, String providerId) async {
    _isAccepting = true;
    notifyListeners();

    try {
      await _service.acceptBookingRequest(
        userId: request.userId,
        providerId: providerId,
        requestId: request.id,
        requestSentAt: request.requestSentAt,
      );
      
      _isAccepting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isAccepting = false;
      notifyListeners();
      print('Error accepting request: $e');
      return false;
    }
  }

  // Reject booking request
  Future<bool> rejectRequest(
    BookingRequest request,
    String providerId, {
    String? reason,
  }) async {
    _isRejecting = true;
    notifyListeners();

    try {
      await _service.rejectBookingRequest(
        userId: request.userId,
        providerId: providerId,
        requestId: request.id,
        requestSentAt: request.requestSentAt,
        rejectionReason: reason,
      );
      
      _isRejecting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isRejecting = false;
      notifyListeners();
      print('Error rejecting request: $e');
      return false;
    }
  }

  // Complete booking request
  Future<bool> completeRequest(BookingRequest request, String providerId) async {
    try {
      await _service.completeBookingRequest(
        userId: request.userId,
        providerId: providerId,
        requestId: request.id,
      );
      return true;
    } catch (e) {
      print('Error completing request: $e');
      return false;
    }
  }

  // Get status color
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // Get status icon
  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.schedule;
      case 'accepted':
        return Icons.check_circle;
      case 'rejected':
        return Icons.cancel;
      case 'completed':
        return Icons.task_alt;
      default:
        return Icons.help_outline;
    }
  }

  // Format time ago
  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }


// // Start work
// Future<bool> startWork(
//   BookingRequest request,
//   String providerId, {
//   required double firstHourCharge,
//   required double perHourCharge,
// }) async {
//   try {
//     await _service.startWorkTimer(
//       userId: request.userId,
//       providerId: providerId,
//       requestId: request.id,
//       firstHourCharge: firstHourCharge,
//       perHourCharge: perHourCharge,
//     );

//     _isWorkInProgress = true;
//     _workDuration = Duration.zero;
    
//     // Start UI timer
//     _workTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _workDuration += Duration(seconds: 1);
//       notifyListeners();
//     });

//     notifyListeners();
//     return true;
//   } catch (e) {
//     print('Error starting work: $e');
//     return false;
//   }
// }

// // Stop work and calculate charges
// Future<Map<String, dynamic>?> stopWork(
//   BookingRequest request,
//   String providerId,
// ) async {
//   try {
//     if (request.workStartTime == null) {
//       throw Exception('Work start time not found');
//     }

//     final result = await _service.stopWorkTimer(
//       userId: request.userId,
//       providerId: providerId,
//       requestId: request.id,
//       workStartTime: request.workStartTime!,
//       firstHourCharge: request.firstHourCharge ?? 0,
//       perHourCharge: request.perHourCharge ?? 0,
//     );

//     _isWorkInProgress = false;
//     _workTimer?.cancel();
//     _workTimer = null;
//     _workDuration = Duration.zero;

//     notifyListeners();
//     return result;
//   } catch (e) {
//     print('Error stopping work: $e');
//     return null;
//   }
// }

// // Calculate current charges in real-time
// double getCurrentCharges(BookingRequest request) {
//   if (request.workStartTime == null) return 0.0;
  
//   final now = DateTime.now();
//   final duration = now.difference(request.workStartTime!);
//   final hours = duration.inMinutes / 60.0;
  
//   if (hours <= 1.0) {
//     return request.firstHourCharge ?? 0.0;
//   } else {
//     final extraHours = hours - 1.0;
//     final extraCharges = extraHours * (request.perHourCharge ?? 0.0);
//     return (request.firstHourCharge ?? 0.0) + extraCharges;
//   }
// }

// // Don't forget to update dispose method
// @override
// void dispose() {
//   _workTimer?.cancel();
//   super.dispose();
// }





// Start work (simplified)
Future<bool> startWork(
  BookingRequest request,
  String providerId,
) async {
  try {
    await _service.startWorkTimer(
      userId: request.userId,
      providerId: providerId,
      requestId: request.id,
    );

    _isWorkInProgress = true;
    _workDuration = Duration.zero;
    
    // Start UI timer
    _workTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _workDuration += Duration(seconds: 1);
      notifyListeners();
    });

    notifyListeners();
    return true;
  } catch (e) {
    print('Error starting work: $e');
    return false;
  }
}

// Stop work and calculate charges (₹200/hr after first hour)
Future<Map<String, dynamic>?> stopWork(
  BookingRequest request,
  String providerId,
) async {
  try {
    if (request.workStartTime == null) {
      throw Exception('Work start time not found');
    }

    final result = await _service.stopWorkTimer(
      userId: request.userId,
      providerId: providerId,
      requestId: request.id,
      workStartTime: request.workStartTime!,
      firstHourCharge: request.price, // ✅ Use price as first hour
    );

    _isWorkInProgress = false;
    _workTimer?.cancel();
    _workTimer = null;
    _workDuration = Duration.zero;

    notifyListeners();
    return result;
  } catch (e) {
    print('Error stopping work: $e');
    return null;
  }
}

// Calculate current charges in real-time (₹200/hr after first hour)
double getCurrentCharges(BookingRequest request) {
  if (request.workStartTime == null) return 0.0;
  
  final now = DateTime.now();
  final duration = now.difference(request.workStartTime!);
  final hours = duration.inMinutes / 60.0;
  
  if (hours <= 1.0) {
    return request.price; // ✅ First hour = price
  } else {
    final extraHours = hours - 1.0;
    final extraCharges = extraHours * 200; // ✅ ₹200/hr after first hour
    return request.price + extraCharges;
  }
}

@override
void dispose() {
  _workTimer?.cancel();
  super.dispose();
}



}
