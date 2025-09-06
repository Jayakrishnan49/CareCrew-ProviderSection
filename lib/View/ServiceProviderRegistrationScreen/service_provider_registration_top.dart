import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';

class CreateServiceProviderScreenTop extends StatelessWidget {
  const CreateServiceProviderScreenTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Service Provider Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'DancingScript',
            color: AppColors.primary
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Complete Your Profile to Offer Services',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'DancingScript',
            color: AppColors.hintText
          ),
        ),
        const SizedBox(height: 30),
        // Consumer<UserProvider>(
        //   builder: (context, userProvider, child) {
        //     return ProfilePicturePicker(
        //       image: userProvider.imagePath, 
        //       onImagePicked: (imagePath) {
        //         userProvider.setImage(imagePath);
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }
}