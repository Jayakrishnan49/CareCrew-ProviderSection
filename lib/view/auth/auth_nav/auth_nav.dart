
// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Controllers/ServiceProvider/service_provider.dart';
// import 'package:project_2_provider/View/Approval/approval.dart';
// import 'package:project_2_provider/View/registration_info_screen/registration_info_screen.dart';
// import 'package:provider/provider.dart';



// class AuthNavigation extends StatelessWidget {
//   const AuthNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final hotelProvider = Provider.of<ServiceProvider>(context, listen: false);

//     Future<String?> checkUserRegistration() async {
//       return await hotelProvider.checkUserRegistration();
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       String? hotelId = await checkUserRegistration();
//       if (hotelId != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>  UserApprovalStatusScreen(),
//           ),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>  RegistrationInfoScreen(),
//           ),
//         );
//       }
//     });

//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:project_2_provider/view/registration_info_screen/registration_info_screen.dart';
import 'package:project_2_provider/view/bottom_nav/bottom_nav_screen.dart';
import 'package:project_2_provider/controllers/service_provider/service_provider.dart';
import 'package:project_2_provider/view/approval/approval.dart';
import 'package:provider/provider.dart';

class AuthNavigation extends StatelessWidget {
  const AuthNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // Step 1: Check if user has registered (has provider ID)
        String? providerId = await serviceProvider.checkUserRegistration();
        
        if (providerId == null) {
          // User hasn't completed registration form yet
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrationInfoScreen(),
            ),
          );
          return;
        }

        // Step 2: User is registered, now check approval status
        await serviceProvider.refreshApprovalStatus();
        
        String? approvalStatus = serviceProvider.approvalStatus;

        if (approvalStatus == 'approved') {
          // Provider is approved - go to main app
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  NavPage(),
            ),
          );
        } else {
          // Provider is pending or rejected - go to approval waiting screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserApprovalStatusScreen(),
            ),
          );
        }
      } catch (e) {
        // Handle any errors
        print('Error in AuthNavigation: $e');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationInfoScreen(),
          ),
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// ===== ALTERNATIVE: Cleaner FutureBuilder Approach =====
class AuthNavigationCleaner extends StatelessWidget {
  const AuthNavigationCleaner({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>>(
      future: _checkAuthStatus(serviceProvider),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error loading. Please restart the app.'),
            ),
          );
        }

        final data = snapshot.data!;
        final bool isRegistered = data['isRegistered'] as bool;
        final String approvalStatus = data['approvalStatus'] as String;

        // Navigate based on status
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isRegistered) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrationInfoScreen(),
              ),
            );
          } else if (approvalStatus == 'approved') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  NavPage(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const UserApprovalStatusScreen(),
              ),
            );
          }
        });

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<Map<String, dynamic>> _checkAuthStatus(ServiceProvider provider) async {
    // Check if user has completed registration
    String? providerId = await provider.checkUserRegistration();
    
    if (providerId == null) {
      return {
        'isRegistered': false,
        'approvalStatus': 'none',
      };
    }

    // User is registered, check approval status
    await provider.refreshApprovalStatus();
    
    return {
      'isRegistered': true,
      'approvalStatus': provider.approvalStatus,
    };
  }
}