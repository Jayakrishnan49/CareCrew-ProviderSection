import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/view/auth/auth_nav/auth_nav.dart';
import 'package:project_2_provider/view/auth/phone_login_screen/phone_login_screen.dart';
import 'package:project_2_provider/view/auth/signup_screen/signup_main.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:provider/provider.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({super.key});

  @override
  Widget build(BuildContext context) {
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
                        MaterialPageRoute(builder: (_) => const AuthNavigation()),
                      );
                    }
                  } catch (e) {
                    // ❌ Error snackbar
                    if (context.mounted) {
                      ModernSnackBar.show(
                        context: context,
                        title: 'Google Sign-In Failed',
                        message: e.toString(),
                        type: SnackBarType.error,
                      );
                    }
                  }
                },
                child: Image.asset(
                  'assets/icons/google_signin_icon.png',
                  width: 40,
                  height: 40,
                ),
              ),

              const SizedBox(width: 40),

              /// Phone login button (not implemented yet)
              InkWell(
                onTap: () {
                  //// navigate to phone login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PhoneLoginScreen()),
                    );
                },
                child: Image.asset(
                  'assets/icons/phonecall_icon.png',
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








