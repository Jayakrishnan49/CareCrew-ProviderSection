// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
// import 'package:project_2_provider/View/Approval/approval.dart';
// import 'package:project_2_provider/View/auth/login_screen/login_main.dart';
// import 'package:provider/provider.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   void navigateUser(BuildContext context) async {
//     final authProvider = Provider.of<ServiceAuthProvider>(context, listen: false);
//     bool isLoggedIn = await authProvider.checkUserLogin();

//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder:
//               (context) =>
//                   isLoggedIn ?  UserApprovalStatusScreen() : const LoginMain(),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future.microtask(() => navigateUser(context));
//     return Scaffold(
//   backgroundColor: AppColors.primary,
//   body: SafeArea(
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
  
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.secondary,
//             ),
//             child: Icon(
//               Icons.build_circle,
//               size: 40,
//               color: AppColors.primary,
//             ),
//           ),
          
//           SizedBox(height: 40),
//           Text(
//             'Partner Hub Care Crew',
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: AppColors.secondary,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );
//   }
// }





import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/view/auth/auth_nav/auth_nav.dart';
import 'package:project_2_provider/view/auth/login_screen/login_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _navigateUser(BuildContext context) async {
    // Wait for splash to show
    await Future.delayed(const Duration(seconds: 2));
    
    if (!context.mounted) return;
    
    // Check Firebase Auth
    final user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      // User is logged in → Go to AuthNavigation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthNavigation()),
      );
    } else {
      // User is NOT logged in → Go to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginMain()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Start navigation after build
    Future.microtask(() => _navigateUser(context));
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //   _navigateUser(context);
  // });
    
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with shadow
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.build_circle,
                  size: 50,
                  color: AppColors.primary,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // App Name
              const Text(
                'Partner Hub',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Care Crew',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Loading indicator
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: AppColors.secondary,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
