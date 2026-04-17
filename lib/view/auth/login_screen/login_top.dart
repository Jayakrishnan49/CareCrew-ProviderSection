import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';

class LoginTop extends StatelessWidget {
  const LoginTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60,),
        Text('Login',
          style: TextStyle(
          color: AppColors.textColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Text('You have been missed !!',
        textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}