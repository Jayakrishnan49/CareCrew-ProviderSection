// import 'dart:developer';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
// import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_main.dart';
// import 'package:project_2_provider/View/Home%20screen/home_screen.dart';
// import 'package:provider/provider.dart';

// class LoginBottom extends StatelessWidget {
//   const LoginBottom({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//           RichText(
//             text: TextSpan(
//               text: "Don't have an acoount?",
//               style: TextStyle(
//                 color: AppColors.textColor,
//                 fontWeight: FontWeight.bold
//               ),
//               children:[
//                 TextSpan(
//                   text: ' Sign Up',
//                   style: TextStyle(
//                     color: AppColors.primary,
//                     decoration: TextDecoration.underline,
//                     fontStyle: FontStyle.italic
//                   ),
//                   recognizer: TapGestureRecognizer()
//                   ..onTap=(){
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => SignupMain(),));
//                   }
//                 ),
//               ]
//             )
//             ),
//             SizedBox(height: 100,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(child: Divider(color: AppColors.grey,)),
//                           Text('   Or continue with   ',style: TextStyle(color: AppColors.hintText),),
//                           Expanded(child: Divider(color: AppColors.grey,)),
//                         ],
//                       ),
//                       SizedBox(height: 20,),
//                       Container(
//                         color: AppColors.secondary,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InkWell(
//                       onTap: () async {
//                         try {
//                           final userCredential =
//                               await context.read<ServiceAuthProvider>().signInWithGoogle();
//                           log(userCredential.user.toString());

//                           if (userCredential.user != null && context.mounted) {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (_) => HomeScreen()),
//                             );
//                           }
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(e.toString())),
//                           );
//                         }
//                       },
//                       child: Image.asset(
//                         'assets/icons/google icon.png',
//                         width: 40,
//                         height: 40,
//                       ),
//                     ),
                        
//                               SizedBox(width: 40,),
                        
//                             GestureDetector(
//                               onTap: () {
//                                 ////navigate to call signin
//                               },
//                               child: Image.asset('assets/icons/call icon.png',width: 40,height: 40,),
//                               )
//                           ],
//                         ),
//                       )
                   
//       ],
//     );
//   }
// }








import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/View/Auth/SignUp%20screen/signup_main.dart';
import 'package:project_2_provider/View/Home%20screen/home_screen.dart';
import 'package:provider/provider.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({super.key});

  @override
  Widget build(BuildContext context) {
    // final authProvider = context.watch<AuthProvider>();

    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: "Don't have an account?",
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' Sign Up',
                style: TextStyle(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignupMain()),
                    );
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Divider(color: AppColors.grey)),
            Text(
              '   Or continue with   ',
              style: TextStyle(color: AppColors.hintText),
            ),
            Expanded(child: Divider(color: AppColors.grey)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          // color: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
                   InkWell(
                      onTap: () async {
                        try {
                          final userCredential =
                              await context.read<ServiceAuthProvider>().signInWithGoogle();
                          log(userCredential.user.toString());

                          if (userCredential.user != null && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                      child: Image.asset(
                        'assets/icons/google icon.png',
                        width: 40,
                        height: 40,
                      ),
                    ),

              const SizedBox(width: 40),

              /// Phone login button (not implemented yet)
              InkWell(
                onTap: () {
                  //// navigate to phone login
                },
                child: Image.asset(
                  'assets/icons/call icon.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}









