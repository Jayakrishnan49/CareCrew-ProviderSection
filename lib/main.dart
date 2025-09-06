import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/Controllers/Custom%20Textform%20Field%20Provider/custom_text_form_field_provider.dart';
import 'package:project_2_provider/Controllers/DropDown/dropdown_controller_provider.dart';
import 'package:project_2_provider/Controllers/ServiceProvider/service_provider.dart';
import 'package:project_2_provider/Controllers/bottomNavProvider/bottom_nav_provider.dart';
import 'package:project_2_provider/View/ServiceProviderRegistrationScreen/service_provider_registration_main.dart';
import 'package:project_2_provider/View/Splash%20screen/splash_screen.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen()
        // home: LoginMain(),
        // home: ServiceProviderRegistrationMain(),

      ),
    );
  }
}
