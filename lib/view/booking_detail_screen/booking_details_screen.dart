// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Controllers/Booking%20Provider/booking_provider.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/action_buttons.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/additional_info_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/booking_detail_app_bar.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/booking_header_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/customer_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/images_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/service_info_card.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';
// import 'package:project_2_provider/widgets/custom_button.dart';
// import 'package:provider/provider.dart';


// class BookingRequestDetailScreen extends StatelessWidget {
//   final BookingRequest request;
//   final String providerId;

//   const BookingRequestDetailScreen({
//     super.key,
//     required this.request,
//     required this.providerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => BookingRequestProvider(),
//       child: Consumer<BookingRequestProvider>(
//         builder: (context, provider, child) {
//           return Scaffold(
//             backgroundColor: Colors.grey[50],
//             body: CustomScrollView(
//               slivers: [
//                 // App Bar
//                 BookingDetailAppBar(),

//                 // Content
//                 SliverToBoxAdapter(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 16),

//                       // Booking ID & Status Card
//                       BookingHeaderCard(request: request),

//                       const SizedBox(height: 12),

//                       // Service Info Card
//                       ServiceInfoCard(request: request),

//                       const SizedBox(height: 12),

//                       // Additional Information (Notes)
//                       if (request.notes.isNotEmpty) ...[
//                         AdditionalInfoCard(notes: request.notes),
//                         const SizedBox(height: 12),
//                       ],

//                       // Images Section
//                       if (request.imageUrls.isNotEmpty) ...[
//                         ImagesCard(imageUrls: request.imageUrls),
//                         const SizedBox(height: 12),
//                       ],

//                       // Customer Details Card
//                       CustomerCard(request: request),

//                       const SizedBox(height: 100),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: request.status == 'pending'
//                 ? ActionButtons(
//                     request: request,
//                     providerId: providerId,
//                     provider: provider,
//                   )
//                 : Padding(
//             padding: const EdgeInsets.all(16),
//             child: CustomButton(
//               text: 'Work Completed',
//               width: double.infinity,
//               borderRadius: 15,
//               onTap: () {
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>ShowParticularServiceProvidersMain(category: category,),));
//                 provider.completeRequest(request, providerId);
                
//               },
//               ),
//           ),
//           );
//         },
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Controllers/Booking%20Provider/booking_provider.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/action_buttons.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/additional_info_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/booking_detail_app_bar.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/booking_header_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/customer_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/images_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/service_info_card.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/start_work_button.dart';
// import 'package:project_2_provider/View/booking_detail_screen/widgets/work_in_progress.dart';
// import 'package:project_2_provider/model/booking_request_model.dart';
// import 'package:provider/provider.dart';


// class BookingRequestDetailScreen extends StatelessWidget {
//   final BookingRequest request;
//   final String providerId;

//   const BookingRequestDetailScreen({
//     super.key,
//     required this.request,
//     required this.providerId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => BookingRequestProvider(),
//       child: Consumer<BookingRequestProvider>(
//         builder: (context, provider, child) {
//           return Scaffold(
//             backgroundColor: Colors.grey[50],
//             body: CustomScrollView(
//               slivers: [
//                 // App Bar
//                 BookingDetailAppBar(),

//                 // Content
//                 SliverToBoxAdapter(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 16),

//                       // Booking ID & Status Card
//                       BookingHeaderCard(request: request),

//                       const SizedBox(height: 12),

//                       // Service Info Card
//                       ServiceInfoCard(request: request),

//                       const SizedBox(height: 12),

//                       // Additional Information (Notes)
//                       if (request.notes.isNotEmpty) ...[
//                         AdditionalInfoCard(notes: request.notes),
//                         const SizedBox(height: 12),
//                       ],

//                       // Images Section
//                       if (request.imageUrls.isNotEmpty) ...[
//                         ImagesCard(imageUrls: request.imageUrls),
//                         const SizedBox(height: 12),
//                       ],

//                       // Customer Details Card
//                       CustomerCard(
//                         request: request,
//                         showPhoneNumber: request.status == 'accepted', // Only show phone for accepted status
//                       ),

//                       const SizedBox(height: 100),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             bottomNavigationBar: _buildBottomButton(context, provider),
//           );
//         },
//       ),
//     );
//   }

//   // Widget? _buildBottomButton(BuildContext context, BookingRequestProvider provider) {
//   //   switch (request.status.toLowerCase()) {
//   //     case 'pending':
//   //       // Show action buttons (Accept/Reject)
//   //       return ActionButtons(
//   //         request: request,
//   //         providerId: providerId,
//   //         provider: provider,
//   //       );
      
//   //     case 'accepted':
//   //       // Show Work Completed button
//   //       return Padding(
//   //         padding: const EdgeInsets.all(16),
//   //         child: CustomButton(
//   //           text: 'Work Completed',
//   //           width: double.infinity,
//   //           borderRadius: 15,
//   //           onTap: () {
//   //             provider.completeRequest(request, providerId);
//   //           },
//   //         ),
//   //       );
      
//   //     case 'rejected':
//   //     case 'completed':
//   //     default:
//   //       // Show no button
//   //       return null;
//   //   }
//   // }

//   Widget? _buildBottomButton(BuildContext context, BookingRequestProvider provider) {
//   switch (request.status.toLowerCase()) {
//     case 'pending':
//       // Show action buttons (Accept/Reject)
//       return ActionButtons(
//         request: request,
//         providerId: providerId,
//         provider: provider,
//       );
    
//     case 'accepted':
//       // ✅ NEW: Check work status and show appropriate widget
//       if (request.workStartTime == null) {
//         // Work not started - show Start Work button
//         return StartWorkButton(
//           request: request,
//           providerId: providerId,
//         );
//       } else if (request.workEndTime == null) {
//         // Work in progress - show timer
//         return WorkInProgressWidget(
//           request: request,
//           providerId: providerId,
//         );
//       } else {
//         // Work completed - show summary
//         // return WorkCompletedSummary(request: request);
//         return null;
//       }
    
//     case 'rejected':
//     case 'completed':
//     default:
//       // Show no button
//       return null;
//   }
// }
// }









import 'package:flutter/material.dart';
import 'package:project_2_provider/Services/booking_request_service.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/action_buttons.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/additional_info_card.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/booking_detail_app_bar.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/booking_header_card.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/completed_receipt_widget.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/customer_card.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/images_card.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/service_info_card.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/start_work_button.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/work_in_progress.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:provider/provider.dart';


class BookingRequestDetailScreen extends StatelessWidget {
  final BookingRequest request;
  final String providerId;

  const BookingRequestDetailScreen({
    super.key,
    required this.request,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingRequestProvider(),
      child: Consumer<BookingRequestProvider>(
        builder: (context, provider, child) {
          return StreamBuilder<BookingRequest?>(
            // Listen to real-time updates of this specific request
            stream: BookingRequestService().getBookingRequestStream(
              providerId: providerId,
              requestId: request.id,
            ),
            builder: (context, snapshot) {
              // Use live request if available, fallback to passed request
              final liveRequest = snapshot.data ?? request;

              return Scaffold(
                backgroundColor: Colors.grey[50],
                body: CustomScrollView(
                  slivers: [
                    BookingDetailAppBar(),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          BookingHeaderCard(request: liveRequest),
                          const SizedBox(height: 12),
                          ServiceInfoCard(request: liveRequest),
                          const SizedBox(height: 12),
                          if (liveRequest.notes.isNotEmpty) ...[
                            AdditionalInfoCard(notes: liveRequest.notes),
                            const SizedBox(height: 12),
                          ],
                          if (liveRequest.imageUrls.isNotEmpty) ...[
                            ImagesCard(imageUrls: liveRequest.imageUrls),
                            const SizedBox(height: 12),
                          ],
                          CustomerCard(
                            request: liveRequest,
                            showPhoneNumber: liveRequest.status == 'accepted',
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: _buildBottomButton(context, provider, liveRequest),
              );
            },
          );
        },
      ),
    );
  }

  Widget? _buildBottomButton(
    BuildContext context,
    BookingRequestProvider provider,
    BookingRequest liveRequest, // use liveRequest here
  ) {
    switch (liveRequest.status.toLowerCase()) {
      case 'pending':
        return ActionButtons(
          request: liveRequest,
          providerId: providerId,
          provider: provider,
        );

      case 'accepted':
        if (liveRequest.workStartTime == null) {
          return StartWorkButton(
            request: liveRequest,
            providerId: providerId,
          );
        } else if (liveRequest.workEndTime == null) {
          return WorkInProgressWidget(
            request: liveRequest,
            providerId: providerId,
          );
        } else {
          return null;
        }
      case 'completed':
      return CompletedReceiptWidget(request: liveRequest);
      case 'rejected':
        return null;
      default:
        return null;
    }
  }
}