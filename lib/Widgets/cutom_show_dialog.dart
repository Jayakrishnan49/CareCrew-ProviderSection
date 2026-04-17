
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/widgets/custom_button.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String? buttonLeft;
  final String? buttonRight;
  final String subTitle;
  final String? imagePath; // Make optional
  final String? animationPath; // Add this
  final VoidCallback onTap;

  const CustomShowDialog({
    super.key,
    required this.title,
    this.buttonLeft,
    this.buttonRight,
    required this.subTitle,
    this.imagePath,
    this.animationPath, // Add this
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          SizedBox(
            height: 200,
            child: animationPath != null
                ? Lottie.asset(
                    animationPath!,
                    repeat: false,
                  )
                : (imagePath != null ? Image.asset(imagePath!) : const SizedBox()),
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.textColor, fontSize: 20),
          ),
        ],
      ),
      content: Text(
        subTitle,
        style: TextStyle(color: AppColors.hintText),
        textAlign: TextAlign.center,
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(top: 15, bottom: 20),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         if (buttonLeft != null) ...[
      //           CustomButton(
      //             text: buttonLeft!,
      //             width: 100,
      //             height: 45,
      //             color: AppColors.hintText,
      //             textColor: AppColors.secondary,
      //             borderRadius: 10,
      //             borderColor: AppColors.hintText,
      //             onTap: () => Navigator.of(context).pop(),
      //           ),
      //           const SizedBox(width: 20),
      //         ],
      //         CustomButton(
      //           text: buttonRight ?? 'OK',
      //           width: 200,
      //           height: 45,
      //           textColor: AppColors.secondary,
      //           color: AppColors.buttonColor,
      //           borderRadius: 10,
      //           borderColor: AppColors.buttonColor,
      //           onTap: onTap,
      //         ),
      //       ],
      //     ),
      //   )
      // ],

      actions: [
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (buttonLeft != null) ...[
          Expanded(
            child: CustomButton(
              text: buttonLeft!,
              height: 45,
              color: AppColors.hintText,
              textColor: AppColors.secondary,
              borderRadius: 10,
              borderColor: AppColors.hintText,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(width: 20),
        ],
        Expanded(
          child: CustomButton(
            text: buttonRight ?? 'OK',
            height: 45,
            textColor: AppColors.secondary,
            color: AppColors.buttonColor,
            borderRadius: 10,
            borderColor: AppColors.buttonColor,
            onTap: onTap,
          ),
        ),
      ],
    ),
  )
],
    );
  }
}