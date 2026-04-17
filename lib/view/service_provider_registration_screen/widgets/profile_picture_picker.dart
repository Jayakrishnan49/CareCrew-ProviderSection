import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/widgets/custom_bottom_sheet.dart';

class ProfilePicturePicker extends StatelessWidget {
  final String? image;
  final Function(String imagePath) onImagePicked;

  const ProfilePicturePicker({
    super.key,
    required this.onImagePicked,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
     
        Container(
          padding: EdgeInsets.all(3), // thickness of the border
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary, // border color
              width: 3, // border width
            ),
          ),
          child: CircleAvatar(
            radius: 65,
            backgroundImage: image != null ? FileImage(File(image!)) : null,
            child: image == null ? Icon(Icons.person, size: 50) : null,
          ),
        ),

        Positioned(
          bottom: 5,
          right: 5,
          child: InkWell(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: AppColors.secondary,
              ),
            ),
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
          ),
        ),
      ],
    );
  }
}
