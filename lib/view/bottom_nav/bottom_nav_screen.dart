import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:project_2_provider/services/booking_request_service.dart';
import 'package:project_2_provider/view/home_screen/home_screen.dart';
import 'package:project_2_provider/view/profile/profile_screen.dart';
import 'package:project_2_provider/view/request_screen/request_screen.dart';
import 'package:project_2_provider/view/schedule_screen/schedule_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavPage extends StatelessWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current provider ID from Firebase Auth
    final String? providerId = FirebaseAuth.instance.currentUser?.uid;

    // List of pages to navigate between
    final List<Widget> pages = [
      const HomeScreen(),
      BookingRequestsScreen(providerId: providerId ?? ''),
      const ScheduleScreen(),
      const ProfileScreen(),
    ];

    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(
                index: navigationProvider.currentIndex,
                children: pages,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: navigationProvider.isBottomNavVisible
                      ? const Offset(0, 0)
                      : const Offset(0, 1),
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.8)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: StreamBuilder<int>(
                      stream: BookingRequestService()
                          .getPendingRequestsCount(providerId ?? ''),
                      builder: (context, snapshot) {
                        final pendingCount = snapshot.data ?? 0;

                        return GNav(
                          gap: 8,
                          activeColor: AppColors.secondary,
                          iconSize: 26,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          duration: const Duration(milliseconds: 400),
                          tabBackgroundColor:
                              AppColors.secondary.withValues(alpha: 0.2),
                          color: Colors.grey[300],
                          selectedIndex: navigationProvider.currentIndex,
                          onTabChange: (index) {
                            navigationProvider.setIndex(index);
                          },
                          tabs: [
                            const GButton(icon: Icons.home, text: 'Home'),
                            GButton(
                              icon: Icons.bookmark_add,
                              text: 'Requests',
                              leading: pendingCount > 0
                                  ? _buildBadge(Icons.bookmark_add, pendingCount)
                                  : null,
                            ),
                            const GButton(icon: Icons.calendar_month, text: 'Schedule'),
                            const GButton(
                                icon: Icons.person, text: 'My Profile'),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge(IconData icon, int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 26, color: Colors.grey[300]),
        Positioned(
          right: -8,
          top: -8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            constraints: const BoxConstraints(
              minWidth: 18,
              minHeight: 18,
            ),
            child: Text(
              count > 99 ? '99+' : count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}