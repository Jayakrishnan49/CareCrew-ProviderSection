// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CustomerCard extends StatelessWidget {
//   final BookingRequest request;

//   const CustomerCard({
//     super.key,
//     required this.request,
//   });

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
//     if (await canLaunchUrl(phoneUri)) {
//       await launchUrl(phoneUri);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.secondary,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'About Customer',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 28,
//                 backgroundColor: AppColors.primary,
//                 backgroundImage: request.userProfileImage.isNotEmpty
//                     ? NetworkImage(request.userProfileImage)
//                     : null,
//                 child: request.userProfileImage.isEmpty
//                     ? Text(
//                         request.userName[0].toUpperCase(),
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         ),
//                       )
//                     : null,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       request.userName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             request.userPhone,
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[600],
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 4),
//                         Text(
//                           request.address.split(',').first,
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: () => _makePhoneCall(request.userPhone),
//                   icon: const Icon(Icons.phone, size: 18),
//                   label: const Text('Call'),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     side: BorderSide(color: Colors.grey[300]!),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     // Chat functionality
//                   },
//                   icon: const Icon(Icons.chat_bubble_outline, size: 18),
//                   label: const Text('Chat'),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     side: BorderSide(color: Colors.grey[300]!),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerCard extends StatelessWidget {
  final BookingRequest request;
  final bool showPhoneNumber;

  const CustomerCard({
    super.key,
    required this.request,
    this.showPhoneNumber = true, // Default to true for backward compatibility
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Customer',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary,
                backgroundImage: request.userProfileImage.isNotEmpty
                    ? NetworkImage(request.userProfileImage)
                    : null,
                child: request.userProfileImage.isEmpty
                    ? Text(
                        request.userName[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.userName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Conditionally show phone number
                    if (showPhoneNumber) ...[
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              request.userPhone,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                    ],
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            request.address.split(',').first,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Conditionally show action buttons
          if (showPhoneNumber) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _makePhoneCall(request.userPhone),
                    icon: const Icon(Icons.phone, size: 18),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ModernSnackBar.show(
                        context: context,
                        title: 'Coming soon...',
                        message: 'Chat feature will be available soon!',
                        type: SnackBarType.info
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text('Chat'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';

// class CustomerCard extends StatelessWidget {
//   final BookingRequest request;
//   final bool showPhoneNumber;

//   const CustomerCard({
//     super.key,
//     required this.request,
//     this.showPhoneNumber = true, // Default to true for backward compatibility
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.secondary,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'About Customer',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[800],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               CircleAvatar(
//                 radius: 28,
//                 backgroundColor: AppColors.primary,
//                 backgroundImage: request.userProfileImage.isNotEmpty
//                     ? NetworkImage(request.userProfileImage)
//                     : null,
//                 child: request.userProfileImage.isEmpty
//                     ? Text(
//                         request.userName[0].toUpperCase(),
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         ),
//                       )
//                     : null,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       request.userName,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     // Always show email (if using userPhone as email in original code)
//                     Row(
//                       children: [
//                         Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             showPhoneNumber ? request.userPhone : '•••••••••••',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey[600],
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 2),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[600]),
//                         const SizedBox(width: 4),
//                         Text(
//                           request.address.split(',').first,
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }