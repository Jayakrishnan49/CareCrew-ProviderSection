import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_main.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
               final userProvider = Provider.of<ServiceAuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text('Home'),
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      ),
      body: Center(
        child:IconButton(onPressed: (){

userProvider.logout();
Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginMain(),));
        }, icon: Icon(Icons.logout)) ,
      ),
    );
  }
}