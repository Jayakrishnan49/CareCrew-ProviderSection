import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:project_2_provider/controllers/home_provider/home_provider.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide HomeProvider above this widget in your widget tree (e.g. in main.dart).
    // Here we just read it.
    final provider = context.read<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: _buildAppBar(context, provider),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          // Provider streams auto-refresh — just wait a moment for UX
          await Future.delayed(const Duration(milliseconds: 800));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActionBanner(context, provider),
              const SizedBox(height: 20),
              _buildTodayStats(provider),
              const SizedBox(height: 24),
              // _buildPendingRequests(context, provider),
              // const SizedBox(height: 24),
              _buildTodayBookings(context, provider),
              const SizedBox(height: 24),
              _buildPerformanceSummary(provider),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // ===== APP BAR =====
  PreferredSizeWidget _buildAppBar(BuildContext context, HomeProvider provider) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      actions: [Padding(
        padding: const EdgeInsets.only(right:8),
        child: IconButton(icon:Icon(Icons.message,color: AppColors.secondary,size: 20,) ,onPressed:(){
          ModernSnackBar.show(
            context: context,
            title: 'comming soon...', 
            message: 'Chat feature will be available soon!',
            type: SnackBarType.info,
          );
        }),
      )],
      title: FutureBuilder(
        future: provider.getUser(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final name = user?.name ?? 'Provider';
          final photo = user?.profilePhoto ?? '';

          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  backgroundImage:
                      photo.isNotEmpty ? NetworkImage(photo) : null,
                  child: photo.isEmpty
                      ? Text(
                          name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.greeting,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ===== ACTION BANNER =====
  Widget _buildActionBanner(BuildContext context, HomeProvider provider) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.pendingRequestsStream,
      builder: (context, snapshot) {
        final pendingCount = snapshot.data?.docs.length ?? 0;
        if (pendingCount == 0) return const SizedBox.shrink();

        return InkWell(
          onTap: () {
            // Navigate to BookingRequestsScreen - Pending tab
            context.read<NavigationProvider>().setIndex(1);
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notification_important_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Action Required!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$pendingCount ${pendingCount == 1 ? 'request' : 'requests'} waiting for response',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===== TODAY'S STATS =====
  Widget _buildTodayStats(HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<QuerySnapshot>(
        stream: provider.allBookingsStream,
        builder: (context, snapshot) {
          final stats = snapshot.hasData
              ? provider.todayStats(snapshot.data!)
              : (active: 0, completed: 0, earnings: 0.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  "Today's Overview",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      stats.active.toString(),
                      'Active Jobs',
                      Icons.work_outline_rounded,
                      const Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      stats.completed.toString(),
                      'Completed',
                      Icons.check_circle_outline_rounded,
                      const Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      '₹${stats.earnings.toStringAsFixed(0)}',
                      'Earned',
                      Icons.currency_rupee_rounded,
                      const Color(0xFF8B5CF6),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
      String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 26, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===== PENDING REQUESTS =====
  // Widget _buildPendingRequests(BuildContext context, HomeProvider provider) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             const Text(
  //               'Pending Requests',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Color(0xFF1F2937),
  //               ),
  //             ),
  //             TextButton.icon(
  //               onPressed: () {
  //                 // Navigate to BookingRequestsScreen
  //               },
  //               icon: const Icon(Icons.arrow_forward, size: 16),
  //               label: const Text('View All'),
  //               style: TextButton.styleFrom(
  //                 foregroundColor: AppColors.primary,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 12),
  //         StreamBuilder<QuerySnapshot>(
  //           stream: provider.pendingPreviewStream,
  //           builder: (context, snapshot) {
  //             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //               return _buildEmptyCard(
  //                 'No Pending Requests',
  //                 'New requests will appear here',
  //                 Icons.inbox_rounded,
  //                 Colors.grey,
  //               );
  //             }
  //             return Column(
  //               children: snapshot.data!.docs.map((doc) {
  //                 final data = doc.data() as Map<String, dynamic>;
  //                 return _buildRequestPreviewCard(context, data, provider);
  //               }).toList(),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildRequestPreviewCard(
  //   BuildContext context,
  //   Map<String, dynamic> data,
  //   HomeProvider provider,
  // ) {
  //   final timeAgo = provider.getTimeAgo(data['createdAt']);
  //   final profileImage = data['userProfileImage'] ?? '';

  //   return InkWell(
  //     onTap: () {},
  //     borderRadius: BorderRadius.circular(16),
  //     child: Container(
  //       margin: const EdgeInsets.only(bottom: 12),
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         border: Border.all(color: Colors.orange.withOpacity(0.2)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.orange.withOpacity(0.05),
  //             blurRadius: 10,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             radius: 24,
  //             backgroundColor: Colors.orange.withOpacity(0.1),
  //             backgroundImage: profileImage.isNotEmpty
  //                 ? NetworkImage(profileImage)
  //                 : null,
  //             child: profileImage.isEmpty
  //                 ? Text(
  //                     (data['userName'] ?? 'U')[0].toUpperCase(),
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.orange,
  //                     ),
  //                   )
  //                 : null,
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   data['userName'] ?? 'Customer',
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xFF1F2937),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
  //                     const SizedBox(width: 4),
  //                     Text(
  //                       timeAgo,
  //                       style: TextStyle(fontSize: 13, color: Colors.grey[600]),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //             decoration: BoxDecoration(
  //               color: Colors.orange.withOpacity(0.1),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: const Text(
  //               'NEW',
  //               style: TextStyle(
  //                 fontSize: 11,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.orange,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ===== TODAY'S SCHEDULE =====
  Widget _buildTodayBookings(BuildContext context, HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          StreamBuilder<QuerySnapshot>(
            stream: provider.acceptedBookingsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final todayBookings = provider.filterToday(snapshot.data!.docs);

              if (todayBookings.isEmpty) {
                return _buildEmptyCard(
                  'No Jobs Today',
                  'Your schedule is clear',
                  Icons.event_available_rounded,
                  Colors.blue,
                );
              }

              return Column(
                children: todayBookings.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return _buildScheduleCard(data);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> data) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.schedule, color: Colors.blue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['time'] ?? 'Time not set',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['userName'] ?? 'Customer',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // ===== PERFORMANCE SUMMARY =====
  Widget _buildPerformanceSummary(HomeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<QuerySnapshot>(
        stream: provider.allBookingsStream,
        builder: (context, snapshot) {
          final stats = snapshot.hasData
              ? provider.performanceStats(snapshot.data!)
              : (total: 0, accepted: 0, completed: 0, acceptanceRate: 0);

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Performance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPerformanceItem(
                      '${stats.acceptanceRate}%',
                      'Acceptance',
                      Icons.trending_up_rounded,
                    ),
                    _buildPerformanceItem(
                      '${stats.completed}',
                      'Completed',
                      Icons.task_alt_rounded,
                    ),
                    _buildPerformanceItem(
                      '${stats.total}',
                      'Total Jobs',
                      Icons.work_history_rounded,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPerformanceItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  // ===== EMPTY STATE =====
  Widget _buildEmptyCard(
      String title, String subtitle, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(icon, size: 48, color: color.withOpacity(0.5)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 4),
            Text(subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}