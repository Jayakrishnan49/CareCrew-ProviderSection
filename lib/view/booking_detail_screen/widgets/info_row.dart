import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool showDiscount;
  final double? discountPrice;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.showDiscount = false,
    this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black,
                ),
              ),
            // if (showDiscount && discountPrice != null && discountPrice! > 0) ...[
            //   const SizedBox(width: 8),
            //   Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     decoration: BoxDecoration(
            //       color: Colors.green.withOpacity(0.1),
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     child: const Text(
            //       '21% Off'
            //       style: TextStyle(
            //         fontSize: 11,
            //         color: Colors.green,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),
      ],
    );
  }
}

class SimpleInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const SimpleInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}