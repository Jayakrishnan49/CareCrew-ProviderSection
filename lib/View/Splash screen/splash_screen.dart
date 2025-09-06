import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_main.dart';
import 'package:project_2_provider/View/bottomNav/bottom_nav_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateUser(BuildContext context) async {
    final authProvider = Provider.of<ServiceAuthProvider>(context, listen: false);
    bool isLoggedIn = await authProvider.checkUserLogin();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  isLoggedIn ?  NavPage() : const LoginMain(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => navigateUser(context));
    return Scaffold(
  backgroundColor: AppColors.primary,
  body: SafeArea(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
  
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary,
            ),
            child: Icon(
              Icons.build_circle,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          
          SizedBox(height: 40),
          Text(
            'Partner Hub Care Crew',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}