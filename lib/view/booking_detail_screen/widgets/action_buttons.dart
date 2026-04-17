// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Controllers/Booking%20Provider/booking_provider.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';
// import 'package:project_2_provider/widgets/custom_snackbar.dart';
// import 'package:project_2_provider/widgets/cutom_show_dialog.dart';

// class ActionButtons extends StatelessWidget {
//   final BookingRequest request;
//   final String providerId;
//   final BookingRequestProvider provider;

//   const ActionButtons({
//     super.key,
//     required this.request,
//     required this.providerId,
//     required this.provider,
//   });

//   void _showAcceptDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => CustomShowDialog(
//         title: 'Accept Booking',
//         subTitle: 'Are you sure you want to accept this booking from ${request.userName}?',
//         animationPath: 'assets/animations/success.json',
//         buttonLeft: 'Cancel',
//         buttonRight: 'Accept',
//         onTap: () async {
//           Navigator.pop(dialogContext);
          
//           final success = await provider.acceptRequest(request, providerId);
          
//           if (context.mounted) {
//             if (success) {
//               CustomSnackBar.show(
//                 context: context,
//                 title: 'Success',
//                 message: 'Booking accepted successfully!',
//                 icon: Icons.check_circle,
//                 iconColor: Colors.white,
//                 backgroundColor: Colors.green,
//               );
//               Navigator.pop(context);
//             } else {
//               CustomSnackBar.show(
//                 context: context,
//                 title: 'Error',
//                 message: 'Failed to accept booking',
//                 icon: Icons.error,
//                 backgroundColor: Colors.red,
//               );
//             }
//           }
//         },
//       ),
//     );
//   }

//   void _showRejectDialog(BuildContext context) {
//     final reasonController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: const Text('Reject Booking'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Reject booking from ${request.userName}?'),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: reasonController,
//                 decoration: InputDecoration(
//                   labelText: 'Reason',
//                   hintText: 'Why are you rejecting?',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 maxLines: 3,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dialogContext),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final reason = reasonController.text.trim();
//                 if (reason.isEmpty) {
//                   CustomSnackBar.show(
//                     context: dialogContext,
//                     title: 'Required',
//                     message: 'Please provide a reason',
//                     backgroundColor: Colors.orange,
//                   );
//                   return;
//                 }
                
//                 Navigator.pop(dialogContext);
                
//                 final success = await provider.rejectRequest(
//                   request,
//                   providerId,
//                   reason: reason,
//                 );
                
//                 if (context.mounted) {
//                   if (success) {
//                     CustomSnackBar.show(
//                       context: context,
//                       title: 'Rejected',
//                       message: 'Booking rejected successfully',
//                       backgroundColor: Colors.orange,
//                     );
//                     Navigator.pop(context);
//                   } else {
//                     CustomSnackBar.show(
//                       context: context,
//                       title: 'Error',
//                       message: 'Failed to reject booking',
//                       backgroundColor: Colors.red,
//                     );
//                   }
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Reject'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () => _showAcceptDialog(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1E293B),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Accept',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () => _showRejectDialog(context),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   side: BorderSide(color: Colors.grey[300]!),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Decline',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/model/booking_request_model.dart';

class ActionButtons extends StatelessWidget {
  final BookingRequest request;
  final String providerId;
  final BookingRequestProvider provider;

  const ActionButtons({
    super.key,
    required this.request,
    required this.providerId,
    required this.provider,
  });

  void showAcceptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Accept Booking',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You are about to accept this booking from:',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('MMM dd, yyyy').format(request.date)} at ${request.time}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Make sure you can complete this service on the scheduled date and time.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                final success = await provider.acceptRequest(request, providerId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            success ? Icons.check_circle : Icons.error,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            success
                                ? 'Booking accepted successfully!'
                                : 'Failed to accept booking',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      backgroundColor: success ? Colors.green : Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  if (success) Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Accept Booking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void showRejectDialog(BuildContext context) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.cancel, color: Colors.red.shade600, size: 28),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Reject Booking', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please provide a reason for rejecting this booking:',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: 'e.g., Not available on this date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () async {
                final reason = reasonController.text.trim();
                if (reason.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: const Text('Please provide a reason'),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext);
                final success = await provider.rejectRequest(
                  request,
                  providerId,
                  reason: reason,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            success ? Icons.check_circle : Icons.error,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            success
                                ? 'Booking rejected'
                                : 'Failed to reject booking',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      backgroundColor: success ? Colors.orange : Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                  if (success) Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Reject Booking',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Reject button
            Expanded(
              child: OutlinedButton(
                onPressed: provider.isRejecting
                    ? null
                    : () => showRejectDialog(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(
                    color: provider.isRejecting ? Colors.grey : Colors.red,
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: provider.isRejecting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.grey,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Reject',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Accept button
            Expanded(
              child: ElevatedButton(
                onPressed: provider.isAccepting
                    ? null
                    : () => showAcceptDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      provider.isAccepting ? Colors.grey : AppColors.buttonColor,
                  foregroundColor: AppColors.secondary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: provider.isAccepting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}