



// import 'package:flutter/material.dart';
// import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
// import 'package:project_2_provider/view/auth/login_screen/login_bottom.dart';
// import 'package:project_2_provider/view/auth/login_screen/login_registration.dart';
// import 'package:project_2_provider/view/auth/login_screen/login_top.dart';

// import 'package:provider/provider.dart';

// class LoginMain extends StatelessWidget {
//   const LoginMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<ServiceAuthProvider>(context);

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 colors: [
//                   Color.fromARGB(255, 255, 255, 255), // Blue
//                   Color.fromARGB(255, 255, 255, 255),
//                   Color.fromARGB(255, 255, 255, 255),   // Light Blue
//                 ],
//               ),
//             ),
//           ),

//           // Main content
//           SingleChildScrollView(
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Center(
//                   child: Column(
//                     children: const [
//                       LoginTop(),
//                       LoginRegistration(),
//                       SizedBox(height: 20),
//                       LoginBottom(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Loader overlay
//           if (authProvider.isLoading)
//             Container(
//               color: Colors.black54,
//               child: const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/view/auth/login_screen/login_bottom.dart';
import 'package:project_2_provider/view/auth/login_screen/login_registration.dart';
import 'package:project_2_provider/view/auth/login_screen/login_top.dart';
import 'package:provider/provider.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ServiceAuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          // Asset image background
          Positioned.fill(
            child: Image.asset(
              'assets/logo/login_bg_img.png', // 🔁 Replace with your actual asset path
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: Column(
                    children: const [
                      LoginTop(),
                      LoginRegistration(),
                      SizedBox(height: 20),
                      LoginBottom(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loader overlay
          if (authProvider.isLoading)
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