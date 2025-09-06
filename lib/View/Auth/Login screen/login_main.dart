// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/View/Auth/Login%20screen/login_bottom.dart';
// import 'package:project_2_provider/View/Auth/Login%20screen/login_registration.dart';
// import 'package:project_2_provider/View/Auth/Login%20screen/login_top.dart';

// class LoginMain extends StatelessWidget {
//   const LoginMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 children: [
//                   LoginTop(),
//                   LoginRegistration(),
//                   SizedBox(height: 20,),
//                   LoginBottom(),
//                   // SizedBox(height: 100,),
//                   // Column(
//                   //   children: [
//                   //     Row(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         Expanded(child: Divider(color: AppColors.grey,)),
//                   //         Text('   Or continue with   ',style: TextStyle(color: AppColors.hintText),),
//                   //         Expanded(child: Divider(color: AppColors.grey,)),
//                   //       ],
//                   //     ),
//                   //     SizedBox(height: 20,),
//                   //     Container(
//                   //       color: AppColors.secondary,
//                   //       child: Row(
//                   //         mainAxisAlignment: MainAxisAlignment.center,
//                   //         children: [
//                   //           GestureDetector(
//                   //             onTap: (){
//                   //               ////navigate to google signin
//                   //             },
//                   //             child: Image.asset('assets/icons/google icon.png',width: 40,height: 40,)
//                   //             ),
                        
//                   //             SizedBox(width: 40,),
                        
//                   //           GestureDetector(
//                   //             onTap: () {
//                   //               ////navigate to call signin
//                   //             },
//                   //             child: Image.asset('assets/icons/call icon.png',width: 40,height: 40,),
//                   //             )
//                   //         ],
//                   //       ),
//                   //     )
//                   //   ],
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_bottom.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_registration.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_top.dart';
import 'package:provider/provider.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ServiceAuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 255, 255, 255), // Blue
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),   // Light Blue
                ],
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
