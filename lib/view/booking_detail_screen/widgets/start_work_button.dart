// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Controllers/Booking%20Provider/booking_provider.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';
// import 'package:project_2_provider/widgets/custom_button.dart';
// import 'package:provider/provider.dart';

// class StartWorkButton extends StatelessWidget {
//   final BookingRequest request;
//   final String providerId;

//   const StartWorkButton({
//     super.key,
//     required this.request,
//     required this.providerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<BookingRequestProvider>(context, listen: false);

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
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Pricing Info
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.blue.shade200),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline, color: Colors.blue, size: 20),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'First hour: ₹${request.firstHourCharge?.toStringAsFixed(0) ?? '0'} • Additional: ₹${request.perHourCharge?.toStringAsFixed(0) ?? '0'}/hr',
//                       style: TextStyle(
//                         color: Colors.blue.shade900,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 12),
            
//             // Start Work Button
//             CustomButton(
//               text: 'Start Work',
//               width: double.infinity,
//               borderRadius: 15,
//               onTap: () async {
//                 final success = await provider.startWork(
//                   request,
//                   providerId,
//                   firstHourCharge: request.firstHourCharge ?? 0,
//                   perHourCharge: request.perHourCharge ?? 0,
//                 );
                
//                 if (success && context.mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Row(
//                         children: [
//                           Icon(Icons.check_circle, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text('Work started! Timer is running.'),
//                         ],
//                       ),
//                       backgroundColor: Colors.green,
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 } else if (context.mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Failed to start work. Please try again.'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/widgets/custom_button.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:provider/provider.dart';

class StartWorkButton extends StatelessWidget {
  final BookingRequest request;
  final String providerId;

  const StartWorkButton({
    super.key,
    required this.request,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingRequestProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pricing Info
            // Container(
            //   padding: EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.blue.shade50,
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: Colors.blue.shade200),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.info_outline, color: Colors.blue, size: 20),
            //       SizedBox(width: 8),
            //       Expanded(
            //         child: Text(
            //           'First hour: ₹${request.price.toStringAsFixed(0)} • Additional: ₹200/hr', // ✅ Fixed rate
            //           style: TextStyle(
            //             color: Colors.blue.shade900,
            //             fontSize: 13,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 12),
            
            // Start Work Button
            // CustomButton(
            //   text: 'Start Work', 
            //   width: double.infinity,
            //   borderRadius: 15,
            //   onTap: () async {
            //     final success = await provider.startWork(
            //       request,
            //       providerId,
            //     ); // ✅ Simplified - no need to pass rates
                
            //     if (success && context.mounted) {
            //       // ScaffoldMessenger.of(context).showSnackBar(
            //       //   SnackBar(
            //       //     content: Row(
            //       //       children: [
            //       //         Icon(Icons.check_circle, color: Colors.white),
            //       //         SizedBox(width: 8),
            //       //         Text('Work started! Timer is running.'),
            //       //       ],
            //       //     ),
            //       //     backgroundColor: Colors.green,
            //       //     behavior: SnackBarBehavior.floating,
            //       //   ),
            //       // );
            //       ModernSnackBar.show(
            //         context: context, 
            //         title: 'Work Started!',
            //         message: 'Timer is running. Complete the job and tap End Work.',
            //         type: SnackBarType.success
            //       );
            //     } else if (context.mounted) {
            //       // ScaffoldMessenger.of(context).showSnackBar(
            //       //   SnackBar(
            //       //     content: Text('Failed to start work. Please try again.'),
            //       //     backgroundColor: Colors.red,
            //       //   ),
            //       // );
            //       ModernSnackBar.show(
            //         context: context, 
            //         title: 'Something Went Wrong',
            //         message: 'Could not start work. Check your connection and try again.',
            //         type: SnackBarType.warning
            //       );
            //     }
            //   },
            // ),

            CustomButton(
  text: 'Start Work',
  width: double.infinity,
  borderRadius: 15,
 onTap: () async {
  final overlay = Overlay.of(context, rootOverlay: true);

  final success = await provider.startWork(request, providerId);

  ModernSnackBar.show(
    context: context,
    overlay: overlay,
    title: success ? 'Work Started!' : 'Something Went Wrong',
    message: success
        ? 'Timer is running. Complete the job and tap End Work.'
        : 'Could not start work. Check your connection and try again.',
    type: success ? SnackBarType.success : SnackBarType.warning,
    duration: Duration(seconds: 5)
  );
},
),
          ],
        ),
      ),
    );
  }
}