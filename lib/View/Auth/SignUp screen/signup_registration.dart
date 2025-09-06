import 'package:flutter/material.dart';
import 'package:project_2_provider/Controllers/Auth%20Provider/auth_provider.dart';
import 'package:project_2_provider/Utilities/app_validators.dart';
import 'package:project_2_provider/View/Auth/Login%20screen/login_main.dart';
import 'package:project_2_provider/Widgets/custom_button.dart';
import 'package:project_2_provider/Widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class SignupRegistration extends StatelessWidget {
  const SignupRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final formKey=GlobalKey<FormState>();
    AppValidators formValidators=AppValidators();
    final userProvider = Provider.of<ServiceAuthProvider>(context, listen: false);

    return Form(
      key: formKey,
      child: Column(
        children: [

          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'E-Mail ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: emailController,
            prefixIcon: Icons.email,
            hintText: 'Enter Email',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formValidators.validateEmail,
          ),
          SizedBox(height: 30,),

          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: passwordController,
            hintText: 'Enter Password',
            prefixIcon: Icons.lock,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formValidators.validatePassword,
          ),
           SizedBox(height: 30,),


          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Confirm Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            controller: confirmPasswordController,
            hintText: 'Enter Password',
            prefixIcon: Icons.lock,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: formValidators.validatePassword,
          ),
          SizedBox(height: 60,),
           CustomButton(
            width: 400,
            onTap: ()async {
                if (formKey.currentState!.validate()) {
                    try  {
                  await  userProvider.signUpAccount(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account created')),
                      );
                      Navigator.of(context).push(MaterialPageRoute(builder:(context) => LoginMain(),));
                    } 
                    catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                }
            },
          text: 'Sign Up',
          borderRadius: 15,
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}