
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_2_provider/model/user_model.dart';

class PermissionServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchApprovedServices() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('service_provider')
          .where('status', isEqualTo: 'approved')
          .get();
               log("Fetched ${snapshot.docs.length} approved services");
        
      return snapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error fetching approved services: $e');
    }
  }}