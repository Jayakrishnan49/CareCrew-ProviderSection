import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/view/service_provider_registration_screen/service_provider_registration_main.dart';
import 'package:project_2_provider/widgets/custom_button.dart';

class RegistrationInfoScreen extends StatelessWidget {
  const RegistrationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // full page background
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Image with curved bottom corners
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
              child: Image.asset(
                'assets/icons/registration_info2.png', // replace with your image
                height: 380,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Title
                  Text(
                    "BECOME A WORKER WITH US?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Join Our Workforce Today",
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),

                  const SizedBox(height: 25),

                  // Features
                  _buildFeature(
                    icon: Icons.access_time,
                    color: AppColors.primary,
                    title: "Increased Job Opportunities",
                    subtitle:
                        "Expand your client base and enjoy flexible working hours.",
                  ),
                  _buildFeature(
                    icon: Icons.verified,
                    color: Colors.red,
                    title: "Enhanced Professional Reputation",
                    subtitle:
                        "Build credibility through user reviews and showcase your work.",
                  ),
                  _buildFeature(
                    icon: Icons.account_balance,
                    color: AppColors.success,
                    title: "Convenient Business Management",
                    subtitle:
                        "Enjoy a hassle-free payment process, with secure and direct earnings deposited into your account.",
                  ),

                  const SizedBox(height: 40),
                  CustomButton(
                    text: 'Register Now',
                    width: 400,
                    borderRadius: 15,
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ServiceProviderRegistrationMain(),));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Help Text
            const Center(
              child: Text("Need Help?", style: TextStyle(color: Colors.grey)),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
