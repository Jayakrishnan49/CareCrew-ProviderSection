import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';

class SignupTop extends StatelessWidget {
  const SignupTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person_outline_outlined,color: AppColors.secondary,size: 50,),
        ),
        SizedBox(height: 20,),
        Text(
          'Hello User !',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 230,
          child: Text(
            'Sign Up For Better Experience',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.hintText,
            ),
          ),
        ),
      ],
    );
  }
}