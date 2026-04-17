import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';

class BookingDetailAppBar extends StatelessWidget {
  const BookingDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.secondary),
      title: const Text(
        'Booking Details',
        style: TextStyle(
          color: AppColors.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}