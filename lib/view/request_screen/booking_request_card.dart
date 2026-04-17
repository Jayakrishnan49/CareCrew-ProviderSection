

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/view/booking_detail_screen/booking_details_screen.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:provider/provider.dart';

class BookingRequestCard extends StatelessWidget {
  final BookingRequest request;
  final String providerId;

  const BookingRequestCard({
    super.key,
    required this.request,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingRequestProvider>();
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      color: AppColors.secondary,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingRequestDetailScreen(
                request: request,
                providerId: providerId,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // User Profile Image (Simple Version)
                  _buildUserAvatar(),
                  const SizedBox(width: 12),
                  
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (request.status == 'pending')
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              provider.getTimeAgo(request.createdAt),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Status Badge
                  _buildStatusBadge(provider),
                ],
              ),
            ),
            
            // Main Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Date & Time Row (Most Important Info)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade100,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Date
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      DateFormat('MMM dd, yyyy').format(request.date),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        
                        // Time
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.access_time,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      request.time,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Location
                  _buildInfoRow(
                    Icons.location_on,
                    'Location',
                    request.address,
                    maxLines: 2,
                  ),
                  
                  // Phone Number (only show if status is accepted)
                  if (request.userPhone.isNotEmpty && request.status == 'accepted') ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.phone,
                      'Phone',
                      request.userPhone,
                    ),
                  ],
                  
                  // Notes (if available)
                  if (request.notes.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 18,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Customer Notes',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  request.notes,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textColor,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  // Price (if available)
                  // if (request.price > 0) ...[
                  
                    // const SizedBox(height: 16),
                    // if(request.status!='rejected')
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 16,
                    //     vertical: 12,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         AppColors.primary.withOpacity(0.1),
                    //         AppColors.primary.withOpacity(0.05),
                    //       ],
                    //     ),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Estimated Price',
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           color: Colors.grey[700],
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Text(
                    //         '₹${request.price.toStringAsFixed(0)}',
                    //         style: const TextStyle(
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.bold,
                    //           color: AppColors.success,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  
                  
                  // Response Time (if available)
                  // if (request.responseTimeMinutes != null) ...[
                  //   const SizedBox(height: 12),
                  //   Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 8,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.green.shade50,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Icon(
                  //           Icons.check_circle,
                  //           size: 16,
                  //           color: Colors.green.shade700,
                  //         ),
                  //         const SizedBox(width: 6),
                  //         Text(
                  //           'Responded in ${request.responseTimeMinutes} minutes',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Colors.green.shade700,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
            
            // Action Buttons (only for pending requests)
            if (request.status == 'pending') ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: provider.isRejecting
                            ? null
                            : () => showRejectDialog(context, provider),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(
                            color: provider.isRejecting
                                ? Colors.grey
                                : Colors.red,
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
                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.isAccepting
                            ? null
                            : () => showAcceptDialog(context, provider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: provider.isAccepting
                              ? Colors.grey
                              : AppColors.buttonColor,
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
            ],
            
            // View Details Button (for non-pending requests)
            // if (request.status != 'pending') ...[
            //   const Divider(height: 1),
            //   Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: SizedBox(
            //       width: double.infinity,
            //       child: OutlinedButton.icon(
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => BookingRequestDetailScreen(
            //                 request: request,
            //                 providerId: providerId,
            //               ),
            //             ),
            //           );
            //         },
            //         icon: const Icon(Icons.visibility_outlined, size: 20,color: AppColors.info,),
            //         label: const Text(
            //           'View Full Details',
            //           style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //             color: AppColors.textColor
            //           ),
            //         ),
            //         style: OutlinedButton.styleFrom(
            //           foregroundColor: AppColors.buttonColor,
            //           side: BorderSide(color: AppColors.buttonColor, width: 2),
            //           padding: const EdgeInsets.symmetric(vertical: 14),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ],

            // View Details Button (for non-pending requests)
if (request.status != 'pending') ...[
  const Divider(height: 1),
  
  // ✅ Payment Status Badge (only for completed)
  if (request.status == 'completed') ...[
    Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: request.paymentStatus == 'paid'
              ? Colors.green.shade50
              : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: request.paymentStatus == 'paid'
                ? Colors.green.shade300
                : Colors.orange.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              request.paymentStatus == 'paid'
                  ? Icons.check_circle
                  : Icons.pending_actions,
              size: 18,
              color: request.paymentStatus == 'paid'
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              request.paymentStatus == 'paid'
                  ? 'Payment Received'
                  : 'Payment Pending',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: request.paymentStatus == 'paid'
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
            const Spacer(),
            Text(
              '₹${(request.price + (request.extraCharges ?? 0)).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: request.paymentStatus == 'paid'
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
          ],
        ),
      ),
    ),
  ],

  Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingRequestDetailScreen(
                request: request,
                providerId: providerId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.visibility_outlined, size: 20, color: AppColors.info),
        label: const Text(
          'View Full Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.buttonColor,
          side: BorderSide(color: AppColors.buttonColor, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  ),
],
          ],
        ),
      ),
    );
  }

  // ✅ Simple User Avatar with Cloudinary Image
  Widget _buildUserAvatar() {
    // Check if user has profile image
    final hasImage = request.userProfileImage.isNotEmpty;
    
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: hasImage
            ? ClipOval(
                child: Image.network(
                  request.userProfileImage,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  // ✅ Simple loading placeholder
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    );
                  },
                  // ✅ Simple error fallback
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      request.userName.isNotEmpty
                          ? request.userName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    );
                  },
                ),
              )
            : Text(
                request.userName.isNotEmpty
                    ? request.userName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
      ),
    );
  }

  Widget _buildStatusBadge(BookingRequestProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: provider.getStatusColor(request.status).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: provider.getStatusColor(request.status).withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            provider.getStatusIcon(request.status),
            size: 16,
            color: provider.getStatusColor(request.status),
          ),
          const SizedBox(width: 6),
          Text(
            request.status.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: provider.getStatusColor(request.status),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showAcceptDialog(BuildContext context, BookingRequestProvider provider) {
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
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
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
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
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
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

  void showRejectDialog(BuildContext context, BookingRequestProvider provider) {
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
                child: Icon(
                  Icons.cancel,
                  color: Colors.red.shade600,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Reject Booking',
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
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
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
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
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
}