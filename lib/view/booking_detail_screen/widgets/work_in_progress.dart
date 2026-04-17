import 'package:flutter/material.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class WorkInProgressWidget extends StatelessWidget {
  final BookingRequest request;
  final String providerId;

  const WorkInProgressWidget({
    super.key,
    required this.request,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingRequestProvider>(context);

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
            // Timer Display Card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.green.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200, width: 2),
              ),
              child: Column(
                children: [
                  // Status Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPulsingDot(),
                      SizedBox(width: 8),
                      Text(
                        'Work in Progress',
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  // Live Timer
                  StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      if (request.workStartTime == null) {
                        return Text('00:00:00');
                      }
                      
                      final elapsed = DateTime.now().difference(request.workStartTime!);
                      final hours = elapsed.inHours;
                      final minutes = elapsed.inMinutes.remainder(60);
                      final seconds = elapsed.inSeconds.remainder(60);
                      
                      return Text(
                        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                          letterSpacing: 3,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  
                  // Current Charges
                  StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      final currentCharges = provider.getCurrentCharges(request);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '₹${currentCharges.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            
            // Complete Work Button
            CustomButton(
              text: 'Complete Work',
              width: double.infinity,
              borderRadius: 15,
              onTap: () => _showCompleteWorkDialog(context, provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPulsingDot() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
      onEnd: () {
        // This creates a continuous pulse effect
      },
    );
  }

//   Future<void> _showCompleteWorkDialog(
//     BuildContext context,
//     BookingRequestProvider provider,
//   ) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(
//           children: [
//             Icon(Icons.check_circle_outline, color: Colors.blue),
//             SizedBox(width: 8),
//             Text('Complete Work?'),
//           ],
//         ),
//         content: Text(
//           'This will stop the timer and calculate the final charges. Are you sure the work is completed?',
//           style: TextStyle(fontSize: 15),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context, true);
//               // provider.completeRequest(request, providerId);
           
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text('Complete', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );

//     // if (confirm == true && context.mounted) {
//     //   final result = await provider.stopWork(request, providerId);
      
//     //   if (result != null && context.mounted) {
//     //     await provider.completeRequest(request, providerId);
//     //     _showCompletionSummary(context, result, provider);
//     //   } else if (context.mounted) {
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       SnackBar(
//     //         content: Text('Failed to complete work. Please try again.'),
//     //         backgroundColor: Colors.red,
//     //       ),
//     //     );
//     //   }
//     // }
//     if (confirm == true && context.mounted) {
//   print('✅ confirmed, calling stopWork...');
  
//   final result = await provider.stopWork(request, providerId);
  
//   print('✅ stopWork result: $result');
//   print('✅ context.mounted: ${context.mounted}');
  
//   if (result != null && context.mounted) {
//     print('✅ calling completeRequest...');
//     await provider.completeRequest(request, providerId);
//     print('✅ calling _showCompletionSummary...');
//     _showCompletionSummary(context, result, provider);
//   } else if (context.mounted) {
//     print('❌ result is null, showing snackbar');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Failed to complete work. Please try again.'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }
//   }

Future<void> _showCompleteWorkDialog(
  BuildContext context,
  BookingRequestProvider provider,
) async {
  // ✅ Capture navigator BEFORE any async operation
  final navigator = Navigator.of(context);

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.blue),
          SizedBox(width: 8),
          Text('Complete Work?'),
        ],
      ),
      content: Text(
        'This will stop the timer and calculate the final charges. Are you sure the work is completed?',
        style: TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('Complete', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );

  if (confirm == true) {
    final result = await provider.stopWork(request, providerId);
    
    print('✅ stopWork result: $result');

    if (result != null) {
      await provider.completeRequest(request, providerId); // ✅ always called now
      
      // ✅ use navigator.context instead of widget context
      showDialog(
        context: navigator.context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Work Completed!'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryRow(
                'Total Hours',
                '${result['totalHours'].toStringAsFixed(2)} hrs',
              ),
              SizedBox(height: 8),
              _buildSummaryRow(
                'Base Charge',
                '₹${request.price.toStringAsFixed(2)}',
              ),
              if (result['extraCharges'] > 0) ...[
                SizedBox(height: 8),
                _buildSummaryRow(
                  'Extra Charges',
                  '₹${result['extraCharges'].toStringAsFixed(2)}',
                  color: Colors.orange,
                ),
              ],
              Divider(height: 24, thickness: 1),
              _buildSummaryRow(
                'Total Amount',
                '₹${result['totalAmount'].toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(navigator.context).showSnackBar(
        SnackBar(
          content: Text('Failed to complete work. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  void _showCompletionSummary(
    BuildContext context,
    Map<String, dynamic> result,
    BookingRequestProvider provider,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Work Completed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow(
              'Total Hours',
              '${result['totalHours'].toStringAsFixed(2)} hrs',
            ),
            SizedBox(height: 8),
            // _buildSummaryRow(
            //   'Base Charge',
            //   '₹${request.firstHourCharge?.toStringAsFixed(2)}',
            // ),
            _buildSummaryRow(
              'Base Charge',
              '₹${request.price.toStringAsFixed(2)}', // ✅ Use price
            ),
            if (result['extraCharges'] > 0) ...[
              SizedBox(height: 8),
              _buildSummaryRow(
                'Extra Charges',
                '₹${result['extraCharges'].toStringAsFixed(2)}',
                color: Colors.orange,
              ),
            ],
            Divider(height: 24, thickness: 1),
            _buildSummaryRow(
              'Total Amount',
              '₹${result['totalAmount'].toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? color, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: color ?? (isTotal ? Colors.green : Colors.black87),
          ),
        ),
      ],
    );
  }
}