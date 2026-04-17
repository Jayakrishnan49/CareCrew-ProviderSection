import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/service_provider/service_provider.dart';
import 'package:project_2_provider/widgets/custom_button.dart';
import 'package:project_2_provider/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:project_2_provider/View/bottom_nav/bottom_nav_screen.dart';

class UserApprovalStatusScreen extends StatelessWidget {
  const UserApprovalStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) {
          // Auto-navigate if approved
          if (provider.approvalStatus == 'approved') {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  NavPage()),
              );
            });
          }

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Image.asset(
                      'assets/icons/verification_waiting.png',
                      height: 380,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Application Under Review',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Message
                    Text(
                      'We have received your application and it\nis currently under review. Our team will\nget in touch with you shortly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.hintText,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Check Status Button
                    provider.isCheckingApproval
                        ? CircularProgressIndicator(color: AppColors.primary)
                        : CustomButton(
                            text: 'Check Status',
                            width: 400,
                            borderRadius: 15,
                            onTap: () => _handleRetry(context, provider),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleRetry(BuildContext context, ServiceProvider provider) async {
    // Refresh approval status
    await provider.refreshApprovalStatus();

    // Show appropriate message based on status
    if (provider.approvalStatus == 'approved') {
      CustomSnackBar.show(
        context: context,
        title: "Approved 🎉",
        message: "Your account has been approved!",
        icon: Icons.check_circle,
        iconColor: Colors.green,
        backgroundColor: Colors.green.shade900,
      );
      // Navigation happens automatically via Consumer above
    } else if (provider.approvalStatus == 'pending') {
      CustomSnackBar.show(
        context: context,
        title: "Still Pending ⏳",
        message: "Your application is still under review.",
        icon: Icons.hourglass_empty,
        iconColor: AppColors.primary,
        backgroundColor: Colors.orange.shade900,
      );
    } else if (provider.approvalStatus == 'rejected') {
      CustomSnackBar.show(
        context: context,
        title: "Application Rejected ❌",
        message: "Please contact support for more information.",
        icon: Icons.cancel,
        iconColor: Colors.red,
        backgroundColor: Colors.red.shade900,
      );
    } else {
      CustomSnackBar.show(
        context: context,
        title: "Error ❌",
        message: "Couldn't fetch status, please try again later.",
        icon: Icons.error,
        iconColor: Colors.red,
        backgroundColor: Colors.red.shade900,
      );
    }
  }
}