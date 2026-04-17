import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2_provider/model/booking_request_model.dart';
import 'package:project_2_provider/view/booking_detail_screen/widgets/info_row.dart';

class ServiceInfoCard extends StatelessWidget {
  final BookingRequest request;

  const ServiceInfoCard({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          InfoRow(
            label: request.serviceType,
            value: request.price > 0 ? '₹${request.price.toStringAsFixed(0)}' : '',
            valueColor: Colors.green,
            showDiscount: true,
            discountPrice: request.price,
          ),
          const SizedBox(height: 12),
          SimpleInfoRow(
            icon: Icons.location_on_outlined,
            text: request.address,
          ),
          const SizedBox(height: 8),
          SimpleInfoRow(
            icon: Icons.calendar_today_outlined,
            text: DateFormat('dd MMMM, yyyy').format(request.date) + ' at ${request.time}',
          ),
          const SizedBox(height: 8),
          SimpleInfoRow(
            icon: Icons.person_outline,
            text: request.userName,
          ),
        ],
      ),
    );
  }
}