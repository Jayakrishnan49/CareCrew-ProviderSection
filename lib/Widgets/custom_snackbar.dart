import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:project_2_provider/constants/app_color.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    IconData icon = Icons.info_rounded,
    Color iconColor = AppColors.secondary,
    Duration duration = const Duration(seconds: 5),
    Color accentColor = AppColors.textColor,
    Color backgroundColor = AppColors.primary,
    Color textColor = AppColors.secondary,
  }) {
    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 16,
              offset: const Offset(0, 4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: accentColor.withAlpha(50),
                  width: 1.5,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    backgroundColor.withAlpha(160),
                    backgroundColor.withAlpha(120),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: TextStyle(
                            color: textColor.withAlpha(220),
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Check if the context is still valid before using it
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: textColor.withAlpha(180),
                      size: 20,
                    ),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}