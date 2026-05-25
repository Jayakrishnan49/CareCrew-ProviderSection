

import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/view/auth/signup_screen/signup_bottom.dart';
import 'package:project_2_provider/view/auth/signup_screen/signup_registration.dart';
import 'package:project_2_provider/view/auth/signup_screen/signup_top.dart';
import 'package:provider/provider.dart';


class SignupMain extends StatelessWidget {
  const SignupMain({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<ServiceAuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      SignupTop(),
                      SizedBox(height: 60),
                      SignupRegistration(),
                      SignupBottom(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🔥 Loader Overlay
          if (userProvider.isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}