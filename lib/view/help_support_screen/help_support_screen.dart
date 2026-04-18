import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Banner ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'How can we help you?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Find answers to common questions or reach out to our support team.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Contact Options ────────────────────────────────────────────
            _SectionLabel(title: 'Contact Us'),
            const SizedBox(height: 12),
            _buildContactCard(
              icon: FaIcon(
                FontAwesomeIcons.envelope,
                color: Colors.orange,
                size: 18,
              ),
              iconColor: Colors.blue,
              title: 'Email Support',
              subtitle: 'supportgoserve@gmail.com',
              trailing: 'Send Email',
              onTap: () => _launchUrl('mailto:supportgoserve@gmail.com'),
              
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              // icon: Icons.phone_outlined,
              icon: FaIcon(
                FontAwesomeIcons.phone,
                color: AppColors.info,
                size: 18,
              ),
              iconColor: Colors.green,
              title: 'Call Us',
              subtitle: '+91 97455 73849',
              trailing: 'Call Now',
              onTap: () => _launchUrl('tel:+919745573849'),
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              // icon: FontAwesomeIcons.whatsapp,
              icon: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: AppColors.success,
              ),
              iconColor: Colors.orange,
              title: 'WhatsApp Support',
              subtitle: 'Chat with us on WhatsApp',
              trailing: 'Open Chat',
              onTap: () => _launchUrl('https://wa.me/919745573849'),
            ),

            const SizedBox(height: 28),

            // ── FAQ ────────────────────────────────────────────────────────
            _SectionLabel(title: 'Frequently Asked Questions'),
            const SizedBox(height: 12),

            _buildFaqCard(
              question: 'How do I accept a booking request?',
              answer:
                  'Go to the Bookings tab and tap on any pending request. You can then choose to Accept or Reject the booking from the detail screen.',
            ),
            const SizedBox(height: 10),
            _buildFaqCard(
              question: 'How do I update my profile details?',
              answer:
                  'Go to Profile → Personal Details and tap the Edit button on the top right. Make your changes and tap Save.',
            ),
            const SizedBox(height: 10),
            _buildFaqCard(
              question: 'How do I change my service type or bank details?',
              answer:
                  'Go to Profile → Documents → Request a Change. Submit a request and our admin team will review and apply the changes within 24 hours.',
            ),
            const SizedBox(height: 10),
            _buildFaqCard(
              question: 'When will I receive my payment?',
              answer:
                  'Payments are processed after the booking is marked as completed and the customer confirms payment. Funds are transferred to your registered bank account within 2-3 business days.',
            ),
            const SizedBox(height: 10),
            _buildFaqCard(
              question: 'What if a customer cancels a booking?',
              answer:
                  'If a customer cancels after you have accepted, the booking will be marked as cancelled in your Bookings tab. Cancellation policies and compensation depend on the time of cancellation.',
            ),
            const SizedBox(height: 10),
            _buildFaqCard(
              question: 'How is my acceptance rate calculated?',
              answer:
                  'Your acceptance rate is the percentage of booking requests you have accepted or completed out of all requests received. A higher rate improves your visibility to customers.',
            ),

            const SizedBox(height: 28),

            // ── App Version ────────────────────────────────────────────────
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required Widget icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              // child: Icon(icon, color: iconColor, size: 22),
              child: icon,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                trailing,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard({
    required String question,
    required String answer,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding:
            const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.quiz_outlined,
              color: AppColors.primary, size: 18),
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

}

class _SectionLabel extends StatelessWidget {
  final String title;

  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2937),
      ),
    );
  }


}