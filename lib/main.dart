

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/controllers/policy_provider/policy_provider.dart';
import 'package:project_2_provider/controllers/auth_provider/auth_provider.dart';
import 'package:project_2_provider/controllers/booking_provider/booking_provider.dart';
import 'package:project_2_provider/controllers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:project_2_provider/controllers/custom_textform_field_provider/custom_text_form_field_provider.dart';
import 'package:project_2_provider/controllers/drop_down/dropdown_controller_provider.dart';
import 'package:project_2_provider/controllers/home_provider/home_provider.dart';
import 'package:project_2_provider/controllers/schedule_provider/schedule_provider.dart';
import 'package:project_2_provider/controllers/service_drop_down/service_dropdown.dart';
import 'package:project_2_provider/controllers/service_provider/service_provider.dart';
import 'package:project_2_provider/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
     WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CustomTextFormFieldProvider()),
                ChangeNotifierProvider(create: (_)=>ServiceAuthProvider()),
                ChangeNotifierProvider(create: (_)=>DropDownProvider()),
                ChangeNotifierProvider(create: (_)=>ServiceProvider()),
                ChangeNotifierProvider(create: (_)=>NavigationProvider()),
                 ChangeNotifierProvider(create: (_)=>DropProvider()..fetchServices()),
                    // ChangeNotifierProvider(create: (_)=>PermissionServiceProvider()),
                    ChangeNotifierProvider(create: (_) => BookingRequestProvider()),
                    ChangeNotifierProvider(create: (_) => HomeProvider()),
                    ChangeNotifierProvider(create: (_) => ScheduleProvider()),
                    ChangeNotifierProvider(create: (_) => PolicyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen(),
        // home: RegistrationInfoScreen(),
        // home: ServiceProviderRegistrationMain(),
        // home: UserApprovalStatusScreen(),

      ),
    );
  }
}
