// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_bottom.dart';
// import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_registration.dart';
// import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_top.dart';

// class SignupMain extends StatelessWidget {
//   const SignupMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                  SignupTop(),
//                  SizedBox(height: 60,),
//                  SignupRegistration(),
//                 //  SizedBox(height: 60,),
//                  SignupBottom (),
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
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_bottom.dart';
import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_registration.dart';
import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_top.dart';

class SignupMain extends StatelessWidget {
  const SignupMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                 SignupTop(),
                 SizedBox(height: 60,),
                 SignupRegistration(),
                //  SizedBox(height: 60,),
                 SignupBottom (),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}