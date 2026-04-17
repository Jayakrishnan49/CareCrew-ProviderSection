// import 'package:flutter/material.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';

// class WorkCompletedSummary extends StatelessWidget {
//   final BookingRequest request;

//   const WorkCompletedSummary({
//     super.key,
//     required this.request,
//   });

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
//             offset: Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade50, Colors.blue.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.blue.shade200, width: 2),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.check_circle,
//                 color: Colors.blue,
//                 size: 48,
//               ),
//               SizedBox(height: 12),
// Text(
// 'Work Completed',
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// color: Colors.blue.shade900,
// ),
// ),
// SizedBox(height: 16),
// _buildInfoRow(
// icon: Icons.timer,
// label: 'Duration',
// value: '${request.totalWorkHours?.toStringAsFixed(2) ?? '0'} hours',
// ),
// SizedBox(height: 8),
// _buildInfoRow(
// icon: Icons.attach_money,
// label: 'Base Charge',
// value: '₹${request.firstHourCharge?.toStringAsFixed(2) ?? '0'}',
// ),
// if (request.extraCharges != null && request.extraCharges! > 0) ...[
// SizedBox(height: 8),
// _buildInfoRow(
// icon: Icons.add_circle_outline,
// label: 'Extra Charges',
// value: '₹${request.extraCharges?.toStringAsFixed(2)}',
// valueColor: Colors.orange.shade700,
// ),
// ],
// Divider(height: 24, thickness: 1),
// _buildInfoRow(
// icon: Icons.payments,
// label: 'Total Amount',
// value: '₹${((request.firstHourCharge ?? 0) + (request.extraCharges ?? 0)).toStringAsFixed(2)}',
// isTotal: true,
// ),
// ],
// ),
// ),
// ),
// );
// }
// Widget _buildInfoRow({
// required IconData icon,
// required String label,
// required String value,
// Color? valueColor,
// bool isTotal = false,
// }) {
// return Row(
// children: [
// Icon(
// icon,
// size: isTotal ? 24 : 20,
// color: isTotal ? Colors.blue.shade700 : Colors.blue.shade600,
// ),
// SizedBox(width: 8),
// Expanded(
// child: Text(
// label,
// style: TextStyle(
// fontSize: isTotal ? 16 : 14,
// fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
// color: Colors.blue.shade900,
// ),
// ),
// ),
// Text(
// value,
// style: TextStyle(
// fontSize: isTotal ? 18 : 15,
// fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
// color: valueColor ?? (isTotal ? Colors.blue.shade700 : Colors.black87),
// ),
// ),
// ],
// );
// }
// }










// import 'package:flutter/material.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';

// class WorkCompletedSummary extends StatelessWidget {
//   final BookingRequest request;

//   const WorkCompletedSummary({
//     super.key,
//     required this.request,
//   });

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
//             offset: Offset(0, -5),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade50, Colors.blue.shade100],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.blue.shade200, width: 2),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.check_circle,
//                 color: Colors.blue,
//                 size: 48,
//               ),
//               SizedBox(height: 12),
//               Text(
//                 'Work Completed',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue.shade900,
//                 ),
//               ),
//               SizedBox(height: 16),
//               _buildInfoRow(
//                 icon: Icons.timer,
//                 label: 'Duration',
//                 value: '${request.totalWorkHours?.toStringAsFixed(2) ?? '0'} hours',
//               ),
//               SizedBox(height: 8),
//               _buildInfoRow(
//                 icon: Icons.attach_money,
//                 label: 'First Hour',
//                 value: '₹${request.price.toStringAsFixed(2)}', // ✅ Use price
//               ),
//               if (request.extraCharges != null && request.extraCharges! > 0) ...[
//                 SizedBox(height: 8),
//                 _buildInfoRow(
//                   icon: Icons.add_circle_outline,
//                   label: 'Extra Charges',
//                   value: '₹${request.extraCharges?.toStringAsFixed(2)}',
//                   valueColor: Colors.orange.shade700,
//                 ),
//               ],
//               Divider(height: 24, thickness: 1),
//               _buildInfoRow(
//                 icon: Icons.payments,
//                 label: 'Total Amount',
//                 value: '₹${(request.price + (request.extraCharges ?? 0)).toStringAsFixed(2)}', // ✅ Simplified
//                 isTotal: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//     Color? valueColor,
//     bool isTotal = false,
//   }) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: isTotal ? 24 : 20,
//           color: isTotal ? Colors.blue.shade700 : Colors.blue.shade600,
//         ),
//         SizedBox(width: 8),
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: isTotal ? 16 : 14,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
//               color: Colors.blue.shade900,
//             ),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 18 : 15,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
//             color: valueColor ?? (isTotal ? Colors.blue.shade700 : Colors.black87),
//           ),
//         ),
//       ],
//     );
//   }
// }