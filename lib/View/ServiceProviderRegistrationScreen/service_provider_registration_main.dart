import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2_provider/Constants/app_color.dart';
import 'package:project_2_provider/Controllers/DropDown/dropdown_controller_provider.dart';
import 'package:project_2_provider/Controllers/ServiceProvider/service_provider.dart';
import 'package:project_2_provider/View/bottomNav/bottom_nav_screen.dart';
import 'package:project_2_provider/Widgets/custom_text_form_field.dart';
import 'package:project_2_provider/model/service_provider_model.dart';
import 'package:provider/provider.dart';
import 'widgets/profile_picture_picker.dart';

class ServiceProviderRegistrationMain extends StatelessWidget {
  ServiceProviderRegistrationMain({super.key});

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController upiController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> serviceOptions = ['Plumber', 'Electrician', 'Doctor', 'Tutor', 'Mechanic'];
      final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    // final formProvider = Provider.of<ServiceProviderFormProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Service Provider Registration',
                    style: TextStyle(fontSize: 25, color: AppColors.primary)),
                const SizedBox(height: 15),
                Text('Complete Your Profile to Offer Services',
                    style: TextStyle(fontSize: 15, color: AppColors.hintText)),
                const SizedBox(height: 40),

                /// Profile Photo
                     Consumer<ServiceProvider>(
          builder: (context, userProvider, child) {
            return ProfilePicturePicker(
              image: userProvider.imagePath, 
              onImagePicked: (imagePath) {
                userProvider.setImage(imagePath);
              },
            );
          },
        ),
               
                const SizedBox(height: 60),

                /// Personal Info Fields
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Enter full name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 30),
    
                /// Gender Dropdown with Provider
                Consumer<DropDownProvider>(
                  builder: (context, provider, _) {
                    return DropdownButtonFormField<String>(
                      initialValue: provider.selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: genderOptions.map((gender) {
                        return DropdownMenuItem(value: gender, child: Text(gender));
                      }).toList(),
                      onChanged: provider.setGender,
                      validator: (value) => value == null ? 'Please select gender' : null,
                    );
                  },
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: phoneController,
                  hintText: 'Enter phone number',
                  labelText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty ? 'Phone number is required' : null,
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Enter email address',
                  labelText: 'Email Address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: addressController,
                  hintText: 'Enter address/location',
                  labelText: 'Address',
                  prefixIcon: Icons.location_on,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty ? 'Address is required' : null,
                ),
                const SizedBox(height: 30),

                /// Service Dropdown with Provider
                Consumer<DropDownProvider>(
                  builder: (context, provider, _) {
                    return DropdownButtonFormField<String>(
                      initialValue: provider.selectedService,
                      decoration: InputDecoration(
                        labelText: 'Service Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: serviceOptions.map((service) {
                        return DropdownMenuItem(value: service, child: Text(service));
                      }).toList(),
                      onChanged: provider.setService,
                      validator: (value) => value == null ? 'Please select a service category' : null,
                    );
                  },
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: experienceController,
                  hintText: 'Years of experience',
                  labelText: 'Experience',
                  prefixIcon: Icons.work,
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Experience is required' : null,
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: businessNameController,
                  hintText: 'Enter business name (optional)',
                  labelText: 'Business Name',
                  prefixIcon: Icons.business,
                  validator: (value) => null,
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  controller: upiController,
                  hintText: 'Enter UPI ID / Bank Details',
                  labelText: 'Payment Details',
                  prefixIcon: Icons.attach_money,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty ? 'Payment details are required' : null,
                ),
                const SizedBox(height: 50),

                /// Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                           final user = _auth.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User not logged in")),
                  );
                  return;
                }

                 final userProvider = Provider.of<ServiceProvider>(context, listen: false);
                                  final dropdataProvider = Provider.of<DropDownProvider>(context, listen: false);

final servicemodel= ServiceModel(email: emailController.text, userId: user.uid, profilePhoto: userProvider.imagePath??'', name: nameController.text, gender: dropdataProvider.selectedGender??'', phoneNumber: phoneController.text, idCardPhoto: '', experienceCertificate: '', yearsOfexperience: experienceController.text, selectService: dropdataProvider.selectedService??'', status: 'pending');
  try {
                  await userProvider.saveUser(servicemodel);
                  
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account created')),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>  NavPage()),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Submitted Successfully!')),
                        );
                      }
                    },
                    child: Text('Submit',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
