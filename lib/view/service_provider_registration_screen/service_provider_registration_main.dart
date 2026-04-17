// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project_2_provider/Constants/app_color.dart';
// import 'package:project_2_provider/Controllers/DropDown/dropdown_controller_provider.dart';
// import 'package:project_2_provider/Controllers/ServiceDropDown/service_dropdown.dart';
// import 'package:project_2_provider/Controllers/ServiceProvider/service_provider.dart';
// import 'package:project_2_provider/View/Approval/approval.dart';
// import 'package:project_2_provider/widgets/custom_snackbar.dart';
// import 'package:project_2_provider/widgets/custom_text_form_field.dart';
// import 'package:project_2_provider/model/user_model.dart';
// import 'package:provider/provider.dart';
// import 'widgets/profile_picture_picker.dart';

// class ServiceProviderRegistrationMain extends StatelessWidget {
//   ServiceProviderRegistrationMain({super.key});

//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController businessNameController = TextEditingController();
//   // final TextEditingController locationController=TextEditingController();
//   final TextEditingController upiController = TextEditingController();

//   final List<String> genderOptions = ['Male', 'Female', 'Other'];

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     // final formProvider = Provider.of<ServiceProviderFormProvider>(context, listen: false);

//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: SafeArea(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Text(
//                   'Service Provider Registration',
//                   style: TextStyle(fontSize: 25, color: AppColors.primary),
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   'Complete Your Profile to Offer Services',
//                   style: TextStyle(fontSize: 15, color: AppColors.hintText),
//                 ),
//                 const SizedBox(height: 40),

//                 /// Profile Photo
//                 Consumer<ServiceProvider>(
//                   builder: (context, userProvider, child) {
//                     return ProfilePicturePicker(
//                       image: userProvider.imagePath,
//                       onImagePicked: (imagePath) {
//                         userProvider.setImage(imagePath);
//                       },
//                     );
//                   },
//                 ),

//                 const SizedBox(height: 60),

//                 /// Personal Info Fields
//                 CustomTextFormField(
//                   controller: nameController,
//                   hintText: 'Enter full name',
//                   labelText: 'Full Name',
//                   prefixIcon: Icons.person,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Name is required' : null,
//                 ),
//                 const SizedBox(height: 30),

//                 /// Gender Dropdown with Provider
//                 Consumer<DropDownProvider>(
//                   builder: (context, provider, _) {
//                     return DropdownButtonFormField<String>(
//                       initialValue: provider.selectedGender,
//                       decoration: InputDecoration(
//                         labelText: 'Gender',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       items: genderOptions.map((gender) {
//                         return DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender),
//                         );
//                       }).toList(),
//                       onChanged: provider.setGender,
//                       validator: (value) =>
//                           value == null ? 'Please select gender' : null,
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: phoneController,
//                   hintText: 'Enter phone number',
//                   labelText: 'Phone Number',
//                   prefixIcon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Phone number is required' : null,
//                 ),
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: emailController,
//                   hintText: 'Enter email address',
//                   labelText: 'Email Address',
//                   prefixIcon: Icons.email,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Email is required' : null,
//                 ),
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: addressController,
//                   hintText: 'Enter address/location',
//                   labelText: 'Address',
//                   prefixIcon: Icons.location_on,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Address is required' : null,
//                 ),
//                 const SizedBox(height: 30),

//                 /// Service Dropdown
//                 Consumer<DropProvider>(
//                   builder: (context, provider, child) {
//                     if (provider.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
                
//                     if (provider.services.isEmpty) {
//                       return const Center(child: Text('No services available'));
//                     }
                
//                     return DropdownButton<String>(
//                       value: provider.selectedService,
//                       hint: const Text('Select a service'),
//                       isExpanded: true,
//                       items: provider.services
//                           .map((service) => DropdownMenuItem<String>(
//                                 value: service.name,
//                                 child: Text(service.name),
//                               ))
//                           .toList(),
//                       onChanged: (String? newValue) {
//                         provider.setSelectedService(newValue);
//                       },
//                     );
//                   },
//                 ),
            
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: experienceController,
//                   hintText: 'Years of experience',
//                   labelText: 'Experience',
//                   prefixIcon: Icons.work,
//                   keyboardType: TextInputType.number,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Experience is required' : null,
//                 ),
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: businessNameController,
//                   hintText: 'Enter business name (optional)',
//                   labelText: 'Business Name',
//                   prefixIcon: Icons.business,
//                   validator: (value) => null,
//                 ),
//                 const SizedBox(height: 30),

//                 CustomTextFormField(
//                   controller: upiController,
//                   hintText: 'Enter UPI ID / Bank Details',
//                   labelText: 'Payment Details',
//                   prefixIcon: Icons.attach_money,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Payment details are required' : null,
//                 ),
//                 const SizedBox(height: 50),

//                 /// Submit Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.buttonColor,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         final user = _auth.currentUser;
//                         if (user == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("User not logged in")),
//                           );
//                           return;
//                         }

//                         final userProvider = Provider.of<ServiceProvider>(
//                           context,
//                           listen: false,
//                         );
//                         final dropdataProvider = Provider.of<DropDownProvider>(
//                           context,
//                           listen: false,
//                         );
//                         final serviceDropProvider = Provider.of<DropProvider>(
//                           context,
//                           listen: false,
//                         );

//                         final servicemodel = UserModel(
//                           email: emailController.text,
//                           userId: user.uid,
//                           profilePhoto: userProvider.imagePath ?? '',
//                           name: nameController.text,
//                           gender: dropdataProvider.selectedGender ?? '',
//                           phoneNumber: phoneController.text,
//                           location: addressController.text,
//                           idCardPhoto: '',
//                           experienceCertificate: '',
//                           yearsOfexperience: experienceController.text,
//                           selectService: serviceDropProvider.selectedService ?? '',
//                           status: 'pending',
//                         );
//                         try {
//                           await userProvider.saveUser(servicemodel);

//                           if (context.mounted) {
//                         //     ScaffoldMessenger.of(context).showSnackBar(
//                         //   const SnackBar(
//                         //     content: Text('Form Submitted Successfully!'),
//                         //   ),
//                         // );
//                         CustomSnackBar.show(
//                       context: context,
//                       title: "Submitted",
//                       message: "Form Submitted Successfully!",
//                       icon: Icons.check_circle,
//                       iconColor: Colors.green,
//                       backgroundColor: Colors.green.shade900
//                     );
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => UserApprovalStatusScreen(),
//                               ),
//                             );
//                           }
//                         } catch (e) {
//                           if (context.mounted) {
//                             // ScaffoldMessenger.of(context).showSnackBar(
//                             //   SnackBar(content: Text('Error: $e')),
//                             // );
//                              CustomSnackBar.show(
//                       context: context,
//                       title: "Error",
//                       message: "Error: $e",
//                       icon: Icons.check_circle,
//                       iconColor: Colors.red,
//                       backgroundColor: Colors.red.shade900
//                     );
//                           }
//                         }

//                         // ScaffoldMessenger.of(context).showSnackBar(
//                         //   const SnackBar(
//                         //     content: Text('Form Submitted Successfully!'),
//                         //   ),
//                         // );
//                       }
//                     },
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2_provider/constants/app_color.dart';
import 'package:project_2_provider/controllers/drop_down/dropdown_controller_provider.dart';
import 'package:project_2_provider/controllers/service_drop_down/service_dropdown.dart';
import 'package:project_2_provider/controllers/service_provider/service_provider.dart';
import 'package:project_2_provider/view/approval/approval.dart';
import 'package:project_2_provider/view/service_provider_registration_screen/widgets/profile_picture_picker.dart';
import 'package:project_2_provider/model/user_model.dart';
import 'package:project_2_provider/widgets/custom_snackbar.dart';
import 'package:project_2_provider/widgets/custom_text_form_field.dart';
import 'package:project_2_provider/widgets/document_picker.dart';
// TODO: Add these imports based on your project structure:
// import 'package:project_2_provider/widgets/custom_snackbar.dart';
// import 'package:project_2_provider/models/user_model.dart';
// import 'package:project_2_provider/screens/user_approval_status_screen.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController firstHourPriceController = TextEditingController();
  final TextEditingController bankAccountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Service Provider Registration',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Complete Your Profile to Offer Services',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.hintText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Profile Photo
                Center(
                  child: Consumer<ServiceProvider>(
                    builder: (context, userProvider, child) {
                      return ProfilePicturePicker(
                        image: userProvider.imagePath,
                        onImagePicked: (imagePath) {
                          userProvider.setImage(imagePath);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),

                // Section: Personal Information
                _buildSectionHeader('Personal Information', Icons.person),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Enter full name',
                  labelText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 20),

                Consumer<DropDownProvider>(
                  builder: (context, provider, _) {
                    return DropdownButtonFormField<String>(
                      value: provider.selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        prefixIcon: Icon(Icons.wc, color: AppColors.primary),
                        filled: true,
                        fillColor: AppColors.secondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.hintText),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.hintText),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                      items: genderOptions.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: provider.setGender,
                      validator: (value) =>
                          value == null ? 'Please select gender' : null,
                    );
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: phoneController,
                  hintText: 'Enter phone number',
                  labelText: 'Phone Number',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) return 'Phone number is required';
                    if (value.length != 10) return 'Enter valid 10-digit number';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Enter email address',
                  labelText: 'Email Address',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'Email is required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: addressController,
                  hintText: 'Enter address/location',
                  labelText: 'Address',
                  prefixIcon: Icons.location_on,
                  maxLines: 3,
                  minLines: 2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isEmpty ? 'Address is required' : null,
                ),
                const SizedBox(height: 40),

                // Section: Service Details
                _buildSectionHeader('Service Details', Icons.work),
                const SizedBox(height: 20),

                Consumer<DropProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (provider.services.isEmpty) {
                      return const Center(child: Text('No services available'));
                    }

                    return DropdownButtonFormField<String>(
                      value: provider.selectedService,
                      decoration: InputDecoration(
                        labelText: 'Select Service',
                        prefixIcon: Icon(Icons.build, color: AppColors.primary),
                        filled: true,
                        fillColor: AppColors.secondary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.hintText),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.hintText),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                      items: provider.services
                          .map((service) => DropdownMenuItem<String>(
                                value: service.name,
                                child: Text(service.name),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        provider.setSelectedService(newValue);
                      },
                      validator: (value) =>
                          value == null ? 'Please select a service' : null,
                    );
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: experienceController,
                  hintText: 'Years of experience',
                  labelText: 'Experience (Years)',
                  prefixIcon: Icons.timeline,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'Experience is required';
                    if (int.tryParse(value) == null) return 'Enter valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: businessNameController,
                  hintText: 'Enter business name',
                  labelText: 'Business Name',
                  prefixIcon: Icons.business,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isEmpty ? 'Business name is required' : null,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: firstHourPriceController,
                  hintText: 'Enter first hour charge',
                  labelText: 'First Hour Price (₹)',
                  prefixIcon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'Price is required';
                    if (int.tryParse(value) == null) return 'Enter valid amount';
                    if (int.parse(value) <= 0) return 'Price must be greater than 0';
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Section: Documents
                _buildSectionHeader('Documents', Icons.folder),
                const SizedBox(height: 20),

                Consumer<ServiceProvider>(
                  builder: (context, userProvider, child) {
                    return DocumentPicker(
                      label: 'ID Card / Aadhaar Card',
                      icon: Icons.badge,
                      isRequired: true,
                      imagePath: userProvider.identityImagePath,
                      onImagePicked: (imagePath) {
                        userProvider.setIdentityImage(imagePath);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                Consumer<ServiceProvider>(
                  builder: (context, userProvider, child) {
                    return DocumentPicker(
                      label: 'Experience Certificate',
                      icon: Icons.description,
                      isRequired: true,
                      imagePath: userProvider.experienceCertificatePath,
                      onImagePicked: (imagePath) {
                        userProvider.setExperienceCertificate(imagePath);
                      },
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Section: Bank Details
                _buildSectionHeader('Bank Details', Icons.account_balance),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: accountHolderController,
                  hintText: 'Enter account holder name',
                  labelText: 'Account Holder Name',
                  prefixIcon: Icons.person_outline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isEmpty ? 'Account holder name is required' : null,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: bankAccountController,
                  hintText: 'Enter account number',
                  labelText: 'Bank Account Number',
                  prefixIcon: Icons.account_balance_wallet,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'Account number is required';
                    if (value.length < 9 || value.length > 18) {
                      return 'Enter valid account number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: ifscController,
                  hintText: 'Enter IFSC code',
                  labelText: 'IFSC Code',
                  prefixIcon: Icons.code,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'IFSC code is required';
                    if (value.length != 11) return 'IFSC must be 11 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: bankNameController,
                  hintText: 'Enter bank name',
                  labelText: 'Bank Name',
                  prefixIcon: Icons.account_balance,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isEmpty ? 'Bank name is required' : null,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  controller: upiController,
                  hintText: 'Enter UPI ID',
                  labelText: 'UPI ID',
                  prefixIcon: Icons.qr_code,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) return 'UPI ID is required';
                    if (!RegExp(r'^[\w.\-_]{3,}@[\w]{3,}$').hasMatch(value)) {
                      return 'Enter valid UPI ID (e.g., name@upi)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user = _auth.currentUser;
                        if (user == null) {
                          CustomSnackBar.show(
                            context: context,
                            title: "Error",
                            message: "User not logged in",
                            icon: Icons.error,
                            iconColor: Colors.red,
                            backgroundColor: Colors.red.shade900,
                          );
                          return;
                        }

                        final userProvider = Provider.of<ServiceProvider>(
                          context,
                          listen: false,
                        );
                        
                        // Check if ID card is uploaded
                        if (userProvider.identityImagePath == null || 
                            userProvider.identityImagePath!.isEmpty) {
                          CustomSnackBar.show(
                            context: context,
                            title: "Missing Document",
                            message: "Please upload your ID card",
                            icon: Icons.warning,
                            iconColor: Colors.orange,
                            backgroundColor: Colors.orange.shade900,
                          );
                          return;
                        }

                        // Check if Experience Certificate is uploaded
                        if (userProvider.experienceCertificatePath == null || 
                            userProvider.experienceCertificatePath!.isEmpty) {
                          CustomSnackBar.show(
                            context: context,
                            title: "Missing Document",
                            message: "Please upload your experience certificate",
                            icon: Icons.warning,
                            iconColor: Colors.orange,
                            backgroundColor: Colors.orange.shade900,
                          );
                          return;
                        }

                        final dropdataProvider = Provider.of<DropDownProvider>(
                          context,
                          listen: false,
                        );
                        final serviceDropProvider = Provider.of<DropProvider>(
                          context,
                          listen: false,
                        );

                        // Show loading
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Uploading documents...',
                                    style: TextStyle(color: AppColors.textColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                        final servicemodel = UserModel(
                          email: emailController.text.trim(),
                          userId: user.uid,
                          profilePhoto: userProvider.imagePath ?? '',
                          name: nameController.text.trim(),
                          gender: dropdataProvider.selectedGender ?? '',
                          phoneNumber: phoneController.text.trim(),
                          location: addressController.text.trim(),
                          idCardPhoto: userProvider.identityImagePath ?? '',
                          experienceCertificate: userProvider.experienceCertificatePath ?? '',
                          yearsOfexperience: experienceController.text.trim(),
                          selectService: serviceDropProvider.selectedService ?? '',
                          status: 'pending',
                          firstHourPrice: firstHourPriceController.text.trim(),
                          bankAccountNumber: bankAccountController.text.trim(),
                          bankIfscCode: ifscController.text.trim().toUpperCase(),
                          bankName: bankNameController.text.trim(),
                          accountHolderName: accountHolderController.text.trim(),
                          upiId: upiController.text.trim(), // Added UPI ID
                          businessName: businessNameController.text.trim(), // Added business name
                        );

                        try {
                          await userProvider.saveUser(servicemodel);

                          if (context.mounted) {
                            Navigator.pop(context); // Close loading dialog
                            
                            CustomSnackBar.show(
                              context: context,
                              title: "Success",
                              message: "Registration submitted successfully!",
                              icon: Icons.check_circle,
                              iconColor: Colors.green,
                              backgroundColor: Colors.green.shade900,
                            );
                            
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => UserApprovalStatusScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            Navigator.pop(context); // Close loading dialog
                            
                            CustomSnackBar.show(
                              context: context,
                              title: "Error",
                              message: "Failed to submit: ${e.toString()}",
                              icon: Icons.error,
                              iconColor: Colors.red,
                              backgroundColor: Colors.red.shade900,
                            );
                          }
                        }
                      }
                    },
                    child: Text(
                      'Submit Registration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Divider(
            color: AppColors.hintText.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}