// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:project_2_provider/constants/app_color.dart';
// import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
// import 'package:project_2_provider/view/auth/auth_nav/auth_nav.dart';
// import 'package:project_2_provider/widgets/custom_button.dart';
// import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
// import 'package:provider/provider.dart';

// class OtpScreen extends StatelessWidget {
//   final String verificationId;
//   final String phoneNumber;

//   const OtpScreen({
//     super.key,
//     required this.verificationId,
//     required this.phoneNumber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<TextEditingController> controllers =
//         List.generate(6, (_) => TextEditingController());
//     final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 40),

//                     // Back button
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: AppColors.primary.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(Icons.arrow_back_ios_new,
//                             color: AppColors.primary, size: 20),
//                       ),
//                     ),

//                     const SizedBox(height: 40),

//                     // Title
//                     Text(
//                       'Enter OTP',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w800,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'We sent a 6-digit OTP to $phoneNumber',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: AppColors.hintText,
//                       ),
//                     ),

//                     const SizedBox(height: 60),

//                     // OTP boxes
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(6, (index) {
//                         return SizedBox(
//                           width: 48,
//                           height: 56,
//                           child: TextFormField(
//                             controller: controllers[index],
//                             focusNode: focusNodes[index],
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             maxLength: 1,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.primary,
//                             ),
//                             decoration: InputDecoration(
//                               counterText: '',
//                               filled: true,
//                               fillColor: AppColors.secondary,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide:
//                                     BorderSide(color: AppColors.hintText),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                     color: AppColors.primary, width: 2),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                     color: AppColors.grey.withOpacity(0.5)),
//                               ),
//                             ),
//                             onChanged: (value) {
//                               if (value.isNotEmpty && index < 5) {
//                                 focusNodes[index + 1].requestFocus();
//                               }
//                               if (value.isEmpty && index > 0) {
//                                 focusNodes[index - 1].requestFocus();
//                               }
//                             },
//                           ),
//                         );
//                       }),
//                     ),

//                     const SizedBox(height: 60),

//                     // Verify Button
//                     Consumer<ServiceAuthProvider>(
//                       builder: (context, provider, _) {
//                         return CustomButton(
//                           width: double.infinity,
//                           borderRadius: 15,
//                           text: 'Verify OTP',
//                           onTap: provider.isLoading
//                               ? null
//                               : () async {
//                                   final otp = controllers
//                                       .map((c) => c.text)
//                                       .join();
//                                   if (otp.length < 6) {
//                                     ModernSnackBar.show(
//                                       context: context,
//                                       title: 'Invalid OTP',
//                                       message: 'Please enter all 6 digits',
//                                       type: SnackBarType.warning,
//                                     );
//                                     return;
//                                   }
//                                   try {
//                                     final user = await provider.verifyOtp(
//                                         verificationId, otp);
//                                     if (user != null && context.mounted) {
//                                       Navigator.pushAndRemoveUntil(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) =>
//                                                 const AuthNavigation()),
//                                         (route) => false,
//                                       );
//                                     }
//                                   } catch (e) {
//                                     if (context.mounted) {
//                                       ModernSnackBar.show(
//                                         context: context,
//                                         title: 'Invalid OTP',
//                                         message:
//                                             'The OTP entered is incorrect',
//                                         type: SnackBarType.error,
//                                       );
//                                     }
//                                   }
//                                 },
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 24),

//                     // Resend OTP
//                     Center(
//                       child: TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(
//                           'Resend OTP',
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Loader overlay
//           Consumer<ServiceAuthProvider>(
//             builder: (context, provider, _) {
//               if (!provider.isLoading) return const SizedBox.shrink();
//               return Container(
//                 color: Colors.black54,
//                 child: const Center(
//                   child: CircularProgressIndicator(color: Colors.white),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }















import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/view/auth/auth_nav/auth_nav.dart';
import 'package:project_2_provider/widgets/custom_button.dart';
import 'package:project_2_provider/widgets/custom_modern_snackbar.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = List.generate(6, (_) => TextEditingController());
    final focusNodes = List.generate(6, (_) => FocusNode());
    final resendSeconds = ValueNotifier<int>(30);
    final isResending = ValueNotifier<bool>(false);
    final currentVerificationId = ValueNotifier<String>(verificationId);

    Timer? timer;
    void startTimer() {
      resendSeconds.value = 30;
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (resendSeconds.value > 0) {
          resendSeconds.value--;
        } else {
          t.cancel();
        }
      });
    }

    startTimer();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Consumer<ServiceAuthProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25.0),
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
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We sent a 6-digit OTP to $phoneNumber',
                        style:
                            TextStyle(fontSize: 14, color: AppColors.hintText),
                      ),

                      const SizedBox(height: 60),

                      // OTP boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 48,
                            height: 56,
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.secondary,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: AppColors.hintText),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(0.5)),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  focusNodes[index + 1].requestFocus();
                                }
                                if (value.isEmpty && index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Timer / Resend
                      Center(
                        child: ValueListenableBuilder<int>(
                          valueListenable: resendSeconds,
                          builder: (context, seconds, _) {
                            if (seconds > 0) {
                              return Text(
                                'Resend OTP in ${seconds}s',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.hintText,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            }
                            return ValueListenableBuilder<bool>(
                              valueListenable: isResending,
                              builder: (context, resending, _) {
                                return TextButton(
                                  onPressed: resending
                                      ? null
                                      : () async {
                                          isResending.value = true;
                                          await provider.verifyPhone(
                                            phoneNumber: phoneNumber,
                                            onVerificationCompleted: (_) {},
                                            onVerificationFailed: (e) {
                                              isResending.value = false; 
                                              if (context.mounted) {
                                                ModernSnackBar.show(
                                                  context: context,
                                                  title: 'Failed to resend',
                                                  message: e.message ??
                                                      'Try again',
                                                  type: SnackBarType.error,
                                                );
                                              }
                                            },
                                            onCodeSent: (newId, _) {
                                              currentVerificationId.value =
                                                  newId;
                                              isResending.value = false;
                                              for (var c in controllers) {
                                                c.clear();
                                              }
                                              focusNodes[0].requestFocus();
                                              startTimer();
                                              if (context.mounted) {
                                                ModernSnackBar.show(
                                                  context: context,
                                                  title: 'OTP Resent',
                                                  message:
                                                      'A new code has been sent.',
                                                  type: SnackBarType.success,
                                                );
                                              }
                                            },
                                            onCodeAutoRetrievalTimeout: (_) {},
                                          );
                                        },
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Verify Button
                      CustomButton(
                        width: double.infinity,
                        borderRadius: 15,
                        text: 'Verify OTP',
                        onTap: provider.isLoading
                            ? null
                            : () async {
                                final otp =
                                    controllers.map((c) => c.text).join();
                                if (otp.length < 6) {
                                  ModernSnackBar.show(
                                    context: context,
                                    title: 'Invalid OTP',
                                    message: 'Please enter all 6 digits',
                                    type: SnackBarType.warning,
                                  );
                                  return;
                                }
                                try {
                                  final user = await provider.verifyOtp(
                                      currentVerificationId.value, otp);
                                  if (user != null && context.mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const AuthNavigation()),
                                      (route) => false,
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ModernSnackBar.show(
                                      context: context,
                                      title: 'Invalid OTP',
                                      message: 'The OTP entered is incorrect',
                                      type: SnackBarType.error,
                                    );
                                  }
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),

              // Loader overlay
              if (provider.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}