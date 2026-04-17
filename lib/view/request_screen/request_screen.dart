import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/view/request_screen/booking_request_card.dart';
import 'package:provider/provider.dart';

class BookingRequestsScreen extends StatelessWidget {
  final String providerId;

  const BookingRequestsScreen({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingRequestProvider(),
      child: Consumer<BookingRequestProvider>(
        builder: (context, provider, child) {
          return DefaultTabController(
            length: 4, 
            child: Scaffold(
              backgroundColor: AppColors.secondary,
              appBar: AppBar(
                backgroundColor: AppColors.primary,
                elevation: 0,
                title: const Text(
                  'Booking Requests',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottom: TabBar(
                  onTap: (index) => provider.setTabIndex(index),
                  indicatorColor: AppColors.secondary,
                  indicatorWeight: 3,
                  labelColor: AppColors.secondary,
                  unselectedLabelColor: AppColors.secondary.withOpacity(0.6),
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.schedule),
                      text: 'Pending',
                    ),
                    Tab(
                      icon: Icon(Icons.work_outline),
                      text: 'Active', // ✅ Changed from "Accepted"
                    ),
                    
                    Tab(
                      icon: Icon(Icons.done_all),
                      text: 'Completed',
                    ),
                    Tab(
                      icon: Icon(Icons.close),
                      text: 'Rejected', 
                    ),
                    
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildRequestsList(context, provider, 'pending'),
                  _buildRequestsList(context, provider, 'accepted'),                 
                  _buildRequestsList(context, provider, 'completed'),
                  _buildRequestsList(context, provider, 'rejected'),
                  //  REMOVED: Rejected tab view
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestsList(
    BuildContext context,
    BookingRequestProvider provider,
    String status,
  ) {
    return StreamBuilder<List<BookingRequest>>(
      stream: provider.getRequestsStreamByStatus(providerId, status),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }

        // Error state
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please try again later',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          );
        }

        // Empty state
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyState(status);
        }

        // Data state
        final requests = snapshot.data!;
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              return BookingRequestCard(
                request: requests[index],
                providerId: providerId,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String status) {
    String message;
    String subtitle;
    IconData icon;
    Color iconColor;

    switch (status) {
      case 'pending':
        message = 'No Pending Requests';
        subtitle = 'New booking requests will appear here';
        icon = Icons.inbox_outlined;
        iconColor = Colors.orange;
        break;
      case 'accepted':
        message = 'No Active Bookings';
        subtitle = 'Accepted bookings in progress will show here';
        icon = Icons.work_outline;
        iconColor = Colors.blue;
        break;
      case 'completed':
        message = 'No Completed Jobs Yet';
        subtitle = 'Your completed work history will appear here';
        icon = Icons.task_alt_outlined;
        iconColor = Colors.green;
        break;
      default:
        message = 'No Requests';
        subtitle = 'Nothing to show here';
        icon = Icons.inbox_outlined;
        iconColor = Colors.grey;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 64,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _StatItem extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;
//   final IconData icon;

//   const _StatItem({
//     required this.label,
//     required this.value,
//     required this.color,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             icon,
//             color: color,
//             size: 28,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }
// }
