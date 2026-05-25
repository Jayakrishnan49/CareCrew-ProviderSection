import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/view/auth/phone_login_screen/otp_screen.dart';
import 'package:project_2_provider/widgets/custom_button.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:project_2_provider/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.arrow_back_ios_new,
                              color: AppColors.primary, size: 20),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Title
                      Text(
                        'Phone Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your phone number to receive an OTP',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                        ),
                      ),

                      const SizedBox(height: 60),

                      // Phone field label
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),

                      // Phone field with +91 prefix
                      CustomTextFormField(
                        controller: phoneController,
                        hintText: 'Enter 10-digit number',
                        prefixIcon: Icons.phone,
                        prefixText: '+91 ',
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          if (value.length != 10) {
                            return 'Enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 60),

                      // Send OTP Button
                      Consumer<ServiceAuthProvider>(
                        builder: (context, provider, _) {
                          return CustomButton(
                            width: double.infinity,
                            borderRadius: 15,
                            text: 'Send OTP',
                            onTap: provider.isLoading
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      final phone =
                                          '+91${phoneController.text.trim()}';
                                      try {
                                        await provider.verifyPhone(
                                          phoneNumber: phone,
                                          onVerificationCompleted: (credential) async {
                                            await provider.auth
                                                .signInWithCredential(credential);
                                          },
                                          onVerificationFailed: (e) {
                                            ModernSnackBar.show(
                                              context: context,
                                              title: 'Verification Failed',
                                              message: e.message ??
                                                  'Something went wrong',
                                              type: SnackBarType.error,
                                            );
                                          },
                                          onCodeSent: (verificationId, _) {
                                            ModernSnackBar.show(
                                              context: context,
                                              title: 'OTP Sent',
                                              message:
                                                  'Check your SMS for the OTP',
                                              type: SnackBarType.success,
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => OtpScreen(
                                                  verificationId: verificationId,
                                                  phoneNumber: phone,
                                                ),
                                              ),
                                            );
                                          },
                                          onCodeAutoRetrievalTimeout: (_) {},
                                        );
                                      } catch (e) {
                                        ModernSnackBar.show(
                                          context: context,
                                          title: 'Error',
                                          message: e.toString(),
                                          type: SnackBarType.error,
                                        );
                                      }
                                    }
                                  },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Loader overlay
          Consumer<ServiceAuthProvider>(
            builder: (context, provider, _) {
              if (!provider.isLoading) return const SizedBox.shrink();
              return Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}