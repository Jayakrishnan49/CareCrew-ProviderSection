
import 'package:flutter/material.dart';
import 'package:project_2_provider/Controllers/ServiceProvider/service_provider.dart';
import 'package:project_2_provider/View/bottomNav/bottom_nav_screen.dart';
import 'package:provider/provider.dart';

import '../../ServiceProviderRegistrationScreen/service_provider_registration_main.dart';


class AuthNavigation extends StatelessWidget {
  const AuthNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<ServiceProvider>(context, listen: false);

    Future<String?> checkUserRegistration() async {
      return await hotelProvider.checkUserRegistration();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? hotelId = await checkUserRegistration();
      if (hotelId != null) {
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
            builder: (context) =>  ServiceProviderRegistrationMain(),
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