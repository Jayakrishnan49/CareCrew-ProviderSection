// import 'package:flutter/material.dart';
// import 'package:project_2_provider/constants/app_color.dart';

// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'About',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // ── App Identity Banner ────────────────────────────────────────
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primary,
//                     AppColors.primary.withOpacity(0.8),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.15),
//                           blurRadius: 20,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.home_repair_service_rounded,
//                       size: 48,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'GoServe Partner',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     'Provider App',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white.withOpacity(0.85),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       'Version 1.0.0',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ── About the App ────────────────────────────────────────
//                   _SectionLabel(title: 'About the App'),
//                   const SizedBox(height: 12),
//                   Container(
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey.shade200),
//                     ),
//                     child: Text(
//                       'GoServe Partner is a platform that connects skilled service providers with customers who need home services. '
//                       'Whether you are a plumber, electrician, carpenter, or any other trade professional, '
//                       'GoServe Partner helps you manage your bookings, grow your client base, and get paid securely — all from one app.',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[700],
//                         height: 1.6,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // ── Key Features ─────────────────────────────────────────
//                   _SectionLabel(title: 'Key Features'),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey.shade200),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildFeatureTile(
//                           icon: Icons.notifications_active_outlined,
//                           iconColor: Colors.orange,
//                           title: 'Real-time Booking Alerts',
//                           subtitle:
//                               'Get notified instantly when a customer books your service',
//                         ),
//                         _buildDivider(),
//                         _buildFeatureTile(
//                           icon: Icons.calendar_today_outlined,
//                           iconColor: Colors.blue,
//                           title: 'Schedule Management',
//                           subtitle:
//                               'View and manage your daily job schedule easily',
//                         ),
//                         _buildDivider(),
//                         _buildFeatureTile(
//                           icon: Icons.account_balance_wallet_outlined,
//                           iconColor: Colors.green,
//                           title: 'Secure Payments',
//                           subtitle:
//                               'Receive payments directly to your bank account',
//                         ),
//                         _buildDivider(),
//                         _buildFeatureTile(
//                           icon: Icons.star_outline_rounded,
//                           iconColor: Colors.amber,
//                           title: 'Performance Tracking',
//                           subtitle:
//                               'Monitor your acceptance rate and completed jobs',
//                         ),
//                         _buildDivider(),
//                         _buildFeatureTile(
//                           icon: Icons.verified_user_outlined,
//                           iconColor: Colors.purple,
//                           title: 'Verified Profile',
//                           subtitle:
//                               'Build trust with customers through a verified provider badge',
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // ── Company Info ─────────────────────────────────────────
//                   _SectionLabel(title: 'Company'),
//                   const SizedBox(height: 12),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey.shade200),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildInfoTile(
//                           icon: Icons.business_outlined,
//                           iconColor: Colors.indigo,
//                           label: 'Company Name',
//                           value: 'ServicePro Technologies Pvt. Ltd.',
//                         ),
//                         _buildDivider(),
//                         _buildInfoTile(
//                           icon: Icons.location_on_outlined,
//                           iconColor: Colors.red,
//                           label: 'Headquarters',
//                           value: 'Kerala, India',
//                         ),
//                         _buildDivider(),
//                         _buildInfoTile(
//                           icon: Icons.email_outlined,
//                           iconColor: Colors.blue,
//                           label: 'Contact Email',
//                           value: 'hello@servicepro.in',
//                         ),
//                         _buildDivider(),
//                         _buildInfoTile(
//                           icon: Icons.language_outlined,
//                           iconColor: Colors.teal,
//                           label: 'Website',
//                           value: 'www.servicepro.in',
//                         ),
//                       ],
//                     ),
//                   ),



//                   const SizedBox(height: 28),

//                   // ── Footer ───────────────────────────────────────────────
//                   Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           '© 2026 GoServe Partner. All rights reserved',
//                           style: TextStyle(
//                               fontSize: 12, color: Colors.grey[400]),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Made with ❤️ in Kerala',
//                           style: TextStyle(
//                               fontSize: 12, color: Colors.grey[400]),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureTile({
//     required IconData icon,
//     required Color iconColor,
//     required String title,
//     required String subtitle,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(9),
//             decoration: BoxDecoration(
//               color: iconColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, color: iconColor, size: 20),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF1F2937),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   subtitle,
//                   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoTile({
//     required IconData icon,
//     required Color iconColor,
//     required String label,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       child: Row(
//         children: [
//           Icon(icon, color: iconColor, size: 20),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style:
//                         TextStyle(fontSize: 12, color: Colors.grey[500])),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF1F2937),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }


//   Widget _buildDivider() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Divider(height: 1, color: Colors.grey[100]),
//     );
//   }
// }

// class _SectionLabel extends StatelessWidget {
//   final String title;

//   const _SectionLabel({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Color(0xFF1F2937),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:project_2_provider/constants/app_color.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── App Identity Banner ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.home_repair_service_rounded,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'GoServe Partner',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Service Provider App',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── About the App ────────────────────────────────────────
                  _SectionLabel(title: 'About the App'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      'GoServe Partner is a platform that connects skilled service providers with customers who need home services. '
                      'Whether you are a plumber, electrician, carpenter, or any other trade professional, '
                      'GoServe Partner helps you manage your bookings, grow your client base, and get paid securely — all from one app.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Key Features ─────────────────────────────────────────
                  _SectionLabel(title: 'Key Features'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildFeatureTile(
                          icon: Icons.notifications_active_outlined,
                          iconColor: Colors.orange,
                          title: 'Real-time Booking Alerts',
                          subtitle:
                              'Get notified instantly when a customer books your service',
                        ),
                        _buildDivider(),
                        _buildFeatureTile(
                          icon: Icons.calendar_today_outlined,
                          iconColor: Colors.blue,
                          title: 'Schedule Management',
                          subtitle:
                              'View and manage your daily job schedule easily',
                        ),
                        _buildDivider(),
                        _buildFeatureTile(
                          icon: Icons.account_balance_wallet_outlined,
                          iconColor: Colors.green,
                          title: 'Secure Payments',
                          subtitle:
                              'Receive payments directly to your bank account',
                        ),
                        _buildDivider(),
                        _buildFeatureTile(
                          icon: Icons.star_outline_rounded,
                          iconColor: Colors.amber,
                          title: 'Performance Tracking',
                          subtitle:
                              'Monitor your acceptance rate and completed jobs',
                        ),
                        _buildDivider(),
                        _buildFeatureTile(
                          icon: Icons.verified_user_outlined,
                          iconColor: Colors.purple,
                          title: 'Verified Profile',
                          subtitle:
                              'Build trust with customers through a verified provider badge',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Developer Info ───────────────────────────────────────
                  _SectionLabel(title: 'Developer'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          icon: Icons.person_outline_rounded,
                          iconColor: Colors.indigo,
                          label: 'Developed by',
                          value: 'Jayakrishnan',
                        ),
                        _buildDivider(),
                        _buildInfoTile(
                          icon: Icons.location_on_outlined,
                          iconColor: Colors.red,
                          label: 'Location',
                          value: 'Kerala, India',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Footer ───────────────────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '© 2026 GoServe Partner. All rights reserved.',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[400]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Made with ❤️ in Kerala',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Colors.grey[100]),
    );
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