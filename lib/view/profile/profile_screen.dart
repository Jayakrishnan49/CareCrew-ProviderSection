import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/model/user_model.dart';
import 'package:project_2_provider/services/user_firebase_service.dart';
import 'package:project_2_provider/view/documents_screen/documents_screen.dart';
import 'package:project_2_provider/view/personal_detail_screen/personal_details_screen.dart';
import 'package:project_2_provider/view/policy_screen/policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userService = UserFirebaseService();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.secondary,
            
          ),
        ),
        // centerTitle: true,
      ),
      body: FutureBuilder<UserModel?>(
        future: userService.getUser(user?.uid ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Failed to load profile'));
          }

          final userData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Profile Card - Main Info
                _buildProfileCard(userData),

                const SizedBox(height: 20),

                // Quick Stats
                // _buildQuickStats(userData),

                // const SizedBox(height: 20),

                // Settings Section
                _buildSettingsSection(context),

                const SizedBox(height: 20),

                // More Section
                _buildMoreSection(context),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===== PROFILE CARD - MAIN INFO =====
  Widget _buildProfileCard(UserModel userData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Picture
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[100],
              backgroundImage: userData.profilePhoto.isNotEmpty
                  ? NetworkImage(userData.profilePhoto)
                  : null,
              child: userData.profilePhoto.isEmpty
                  ? Text(
                      userData.name.isNotEmpty 
                          ? userData.name[0].toUpperCase()
                          : 'P',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    )
                  : null,
            ),
          ),

          const SizedBox(height: 16),

          // Name
          Text(
            userData.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // Phone with Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                userData.phoneNumber,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Email with Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  userData.email,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== QUICK STATS =====
  Widget _buildQuickStats(UserModel userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('service_provider')
            .doc(userData.userId)
            .collection('booking_requests')
            .snapshots(),
        builder: (context, snapshot) {
          int completedJobs = 0;
          int activeJobs = 0;

          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              final data = doc.data() as Map<String, dynamic>;
              if (data['status'] == 'completed') completedJobs++;
              if (data['status'] == 'accepted') activeJobs++;
            }
          }

          return Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  completedJobs.toString(),
                  'Completed',
                  Icons.task_alt,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem(
                  activeJobs.toString(),
                  'Active Jobs',
                  Icons.work,
                  Colors.blue,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // ===== SETTINGS SECTION =====
  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.person,
                  iconColor: Colors.blue,
                  title: 'Personal Details',
                  subtitle: 'View your information',
                  onTap: () {
                    // Navigate to personal details screen
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalDetailsScreen()));
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.description,
                  iconColor: Colors.orange,
                  title: 'Documents',
                  subtitle: 'ID card & certificates',
                  onTap: () {
                    // Navigate to documents screen
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DocumentsScreen()));
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.privacy_tip,
                  iconColor: Colors.green,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    // Navigate to privacy policy
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PolicyScreen(title: 'Privacy Policy', url: 'https://www.freeprivacypolicy.com/live/2f78987a-6106-47b0-86b8-13660dde9c64')));
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.article,
                  iconColor: Colors.purple,
                  title: 'Terms & Conditions',
                  subtitle: 'View terms of service',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PolicyScreen(title: 'Privacy Policy', url: 'https://www.freeprivacypolicy.com/live/1721f3f6-fad8-4c7c-b1f8-51d4f2a7b715')));

                    // Navigate to terms
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== MORE SECTION =====
  Widget _buildMoreSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'More',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.help_outline,
                  iconColor: Colors.cyan,
                  title: 'Help & Support',
                  subtitle: 'Get help with your account',
                  onTap: () {
                    // Navigate to help
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.info_outline,
                  iconColor: Colors.indigo,
                  title: 'About',
                  subtitle: 'Learn more about us',
                  onTap: () {
                    // Navigate to about
                  },
                ),
                _buildDivider(),
                _buildMenuItem(
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  title: 'Logout',
                  subtitle: 'Sign out of your account',
                  onTap: () => _showLogoutDialog(context),
                  showArrow: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== MENU ITEM =====
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Colors.grey[200]),
    );
  }

  // ===== LOGOUT DIALOG =====
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pop(dialogContext);
                  // Navigate to login screen
                  // Navigator.pushReplacementNamed(context, '/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
