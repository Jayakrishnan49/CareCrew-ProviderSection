import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/widgets/custom_bottom_sheet.dart';

class DocumentPicker extends StatelessWidget {
  final String? imagePath;
  final Function(String imagePath) onImagePicked;
  final String label;
  final IconData icon;
  final bool isRequired;

  const DocumentPicker({
    super.key,
    required this.onImagePicked,
    required this.label,
    this.imagePath,
    this.icon = Icons.upload_file,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return CustomCameraGalleryBottomSheet(
                  onImagePicked: (imagePath) {
                    onImagePicked(imagePath);
                  },
                );
              },
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(
                color: imagePath != null ? AppColors.primary : AppColors.hintText,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: imagePath != null
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imagePath!),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Document uploaded',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap to change',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.hintText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: AppColors.hintText,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Tap to upload $label',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}