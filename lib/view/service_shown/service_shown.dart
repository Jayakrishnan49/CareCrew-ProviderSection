// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:project_2_provider/model/service_model.dart';
// import 'package:project_2_provider/services/user_firebase_service.dart';
// import 'package:provider/provider.dart';

// // UserFirebaseService class to fetch data from Firestore
// // class UserFirebaseService {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   String get userId => _auth.currentUser!.uid;



// //   CollectionReference get _servicesCollection =>
// //       _firestore.collection('services');

// //   // FETCH all services
// //   Future<List<WorkModel>> getAllServices() async {
// //     try {
// //       QuerySnapshot querySnapshot = await _servicesCollection.get();
// //       return querySnapshot.docs
// //           .map((doc) => WorkModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
// //           .toList();
// //     } catch (e) {
// //       print("Error fetching services: $e");
// //       return [];
// //     }
// //   }
// // }

// // Provider class to manage services data
// class DropProvider with ChangeNotifier {
//   List<WorkModel> _services = [];
//   String? _selectedService;
//   bool _isLoading = false;

//   List<WorkModel> get services => _services;
//   String? get selectedService => _selectedService;
//   bool get isLoading => _isLoading;

//   Future<void> fetchServices() async {
//     _isLoading = true;
//     notifyListeners();

//     final userFirebaseService = UserFirebaseService();
//     _services = await userFirebaseService.getAllServices();
    
//     _isLoading = false;
//     notifyListeners();
//   }

//   void setSelectedService(String? serviceName) {
//     _selectedService = serviceName;
//     notifyListeners();
//   }


//   //////
//   ///
  
// }

// // Dropdown widget to display service names
// class ServicesDropdown extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => DropProvider()..fetchServices(),
//       child: Consumer<DropProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.services.isEmpty) {
//             return const Center(child: Text('No services available'));
//           }

//           return DropdownButton<String>(
//             value: provider.selectedService,
//             hint: const Text('Select a service'),
//             isExpanded: true,
//             items: provider.services
//                 .map((service) => DropdownMenuItem<String>(
//                       value: service.name,
//                       child: Text(service.name),
//                     ))
//                 .toList(),
//             onChanged: (String? newValue) {
//               provider.setSelectedService(newValue);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Example usage in a Flutter widget
// class ServicesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Services Dropdown')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ServicesDropdown(),
//             const SizedBox(height: 20),
//             Consumer<DropProvider>(
//               builder: (context, provider, child) {
//                 return Text(
//                   provider.selectedService != null
//                       ? 'Selected: ${provider.selectedService}'
//                       : 'No service selected',
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }