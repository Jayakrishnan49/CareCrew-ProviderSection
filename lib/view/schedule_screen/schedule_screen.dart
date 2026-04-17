import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/schedule_provider/schedule_provider.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/view/booking_detail_screen/booking_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ScheduleProvider>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Schedule",
            style: TextStyle(color: AppColors.secondary)),
      ),
      // body: Column(
      //   children: [
      //     TableCalendar(
      //       firstDay: DateTime.utc(2020, 1, 1),
      //       lastDay: DateTime.utc(2030, 12, 31),
      //       focusedDay: controller.focusedDay,
      //       selectedDayPredicate: (day) =>
      //           isSameDay(controller.selectedDay, day),
      //       onDaySelected: (selectedDay, focusedDay) =>
      //           context
      //               .read<ScheduleProvider>()
      //               .onDaySelected(selectedDay, focusedDay),
      //       calendarStyle: const CalendarStyle(
      //         selectedDecoration: BoxDecoration(
      //           color: Colors.blue,
      //           shape: BoxShape.circle,
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 8),
      //     Expanded(
      //       child: _buildDayBookings(controller),
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
  slivers: [
    // Calendar as a sliver
    SliverToBoxAdapter(
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.focusedDay,
        selectedDayPredicate: (day) =>
            isSameDay(controller.selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) =>
            context
                .read<ScheduleProvider>()
                .onDaySelected(selectedDay, focusedDay),
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),

    const SliverToBoxAdapter(child: SizedBox(height: 8)),

    // Bookings list as a sliver
    StreamBuilder<List<BookingRequest>>(
      stream: controller.bookingStream,
      builder: (context, snapshot) {
        if (controller.selectedDay == null) {
          return const SliverFillRemaining(
            child: Center(child: Text("Select a date")),
          );
        }
        if (!snapshot.hasData) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final allDocs = snapshot.data!;
        final accepted  = allDocs.where((b) => b.status == 'accepted').toList();
        final completed = allDocs.where((b) => b.status == 'completed').toList();
        final rejected  = allDocs.where((b) => b.status == 'rejected').toList();

        if (allDocs.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: Text("No bookings for this date")),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              if (accepted.isNotEmpty) ...[
                _sectionHeader("Accepted", Colors.blue),
                ...accepted.map((b) => _bookingCard(context, b)),
              ],
              if (completed.isNotEmpty) ...[
                _sectionHeader("Completed", Colors.green),
                ...completed.map((b) => _bookingCard(context, b)),
              ],
              if (rejected.isNotEmpty) ...[
                _sectionHeader("Rejected", Colors.red),
                ...rejected.map((b) => _bookingCard(context, b)),
              ],
            ]),
          ),
        );
      },
    ),
  ],
),
    );
  }

  // Widget _buildDayBookings(ScheduleProvider controller) {
  //   if (controller.selectedDay == null) {
  //     return const Center(child: Text("Select a date"));
  //   }

  //   return StreamBuilder<List<BookingRequest>>(
  //     stream: controller.bookingStream,
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return const Center(child: CircularProgressIndicator());
  //       }

  //       final allDocs = snapshot.data!;
  //       final accepted  = allDocs.where((b) => b.status == 'accepted').toList();
  //       final completed = allDocs.where((b) => b.status == 'completed').toList();
  //       final rejected  = allDocs.where((b) => b.status == 'rejected').toList();

  //       if (allDocs.isEmpty) {
  //         return const Center(child: Text("No bookings for this date"));
  //       }

  //       return ListView(
  //         padding: const EdgeInsets.all(16),
  //         children: [
  //           if (accepted.isNotEmpty) ...[
  //             _sectionHeader("Accepted", Colors.blue),
  //             ...accepted.map((b) => _bookingCard(context,b)),
  //           ],
  //           if (completed.isNotEmpty) ...[
  //             _sectionHeader("Completed", Colors.green),
  //             ...completed.map((b) => _bookingCard(context,b)),
  //           ],
  //           if (rejected.isNotEmpty) ...[
  //             _sectionHeader("Rejected", Colors.red),
  //             ...rejected.map((b) => _bookingCard(context,b)),
  //           ],
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _sectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

Widget _bookingCard(BuildContext context, BookingRequest booking) {
  final Map<String, Map<String, dynamic>> statusStyle = {
    'accepted': {
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFF2196F3),
      'label': 'Accepted',
      'bg': const Color(0xFFE3F2FD),
      'gradient': [const Color(0xFF1E88E5), const Color(0xFF42A5F5)],
    },
    'completed': {
      'icon': Icons.task_alt_rounded,
      'color': const Color(0xFF43A047),
      'label': 'Completed',
      'bg': const Color(0xFFE8F5E9),
      'gradient': [const Color(0xFF388E3C), const Color(0xFF66BB6A)],
    },
    'rejected': {
      'icon': Icons.cancel_rounded,
      'color': const Color(0xFFE53935),
      'label': 'Rejected',
      'bg': const Color(0xFFFFEBEE),
      'gradient': [const Color(0xFFD32F2F), const Color(0xFFEF5350)],
    },
  };

  final style = statusStyle[booking.status] ?? statusStyle['accepted']!;
  final Color statusColor = style['color'] as Color;
  final Color bgColor = style['bg'] as Color;
  final List<Color> gradientColors = style['gradient'] as List<Color>;

  // Check if profile image URL exists and is not empty
  final bool hasImage =
      booking.userProfileImage.isNotEmpty;

  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingRequestDetailScreen(
          request: booking,
          providerId: FirebaseAuth.instance.currentUser!.uid,
        ),
      ),
    ),
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.12),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left gradient accent bar
              Container(
                width: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Profile image or initial avatar
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: bgColor,
                            backgroundImage: hasImage
                                ? NetworkImage(booking.userProfileImage)
                                : null,
                            child: !hasImage
                                ? Text(
                                    booking.userName.isNotEmpty
                                        ? booking.userName[0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: statusColor,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 10),

                          // Name only (no service type)
                          Expanded(
                            child: Text(
                              booking.userName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                              ),
                            ),
                          ),

                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: statusColor.withOpacity(0.3)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(style['icon'] as IconData,
                                    size: 11, color: statusColor),
                                const SizedBox(width: 4),
                                Text(
                                  style['label'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Gradient divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey.shade200,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Time and Address info rows only
                      _infoRow(Icons.access_time_rounded, booking.time, statusColor),
                      const SizedBox(height: 6),
                      _infoRow(Icons.location_on_rounded, booking.address, statusColor),
                    ],
                  ),
                ),
              ),

              // Arrow
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.chevron_right_rounded,
                    color: Colors.grey.shade400, size: 22),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _infoRow(IconData icon, String text, Color iconColor) {
  return Row(
    children: [
      Icon(icon, size: 14, color: iconColor.withOpacity(0.7)),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
}