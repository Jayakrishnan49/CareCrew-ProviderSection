import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_2_provider/model/service_model.dart';
import 'package:project_2_provider/model/user_model.dart';

class UserFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser!.uid;

  CollectionReference get _usersCollection =>
      _firestore.collection('service_provider');

       CollectionReference get _servicesCollection =>
      _firestore.collection('services');

  // CREATE or UPDATE user
  Future<void> createOrUpdateUser(UserModel user) async {
    await _usersCollection.doc(user.userId).set(user.toJson());
  }

  // READ user
  Future<UserModel?> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // UPDATE specific fields
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    await _usersCollection.doc(userId).update(updates);
  }

  // DELETE user
  Future<void> deleteUser(String userId) async {
    await _usersCollection.doc(userId).delete();
  }

  // CHECK if user is already registered
  Future<String?> checkUserRegistration() async {
    try {
      String currentUserId = _auth.currentUser!.uid;

      QuerySnapshot userQuery = await _usersCollection
          .where('userId', isEqualTo: currentUserId)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        return userQuery.docs.first.id; // Firestore doc ID
      } else {
        return null;
      }
    } catch (e) {
      print("Error checking user registration: $e");
      return null;
    }
  }

    // FETCH all services
  Future<List<WorkModel>> getAllServices() async {
    try {
      QuerySnapshot querySnapshot = await _servicesCollection.get();
      return querySnapshot.docs
          .map((doc) => WorkModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching services: $e");
      return [];
    }
  }




Future<String?> getUserApprovalStatus() async {
  final doc = await _usersCollection.doc(userId).get();
  if (doc.exists) {
    return (doc.data() as Map<String, dynamic>)['status'] ?? 'pending';
  }
  return null;
}


    Future<bool> isUserApproved() async {
    try {
      QuerySnapshot userQuery = await _usersCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'approved')
          .limit(1)
          .get();

      return userQuery.docs.isNotEmpty;
    } catch (e) {
      // print("Error checking user approval status: $e");  
      return false;
    }
  }


  // ── SERVICE SELECTION ──────────────────────────────────────────────────────

Future<void> updateProviderServices(List<String> serviceIds) async {
  await _usersCollection.doc(userId).update({'serviceIds': serviceIds});
}

Future<List<String>> getProviderServiceIds() async {
  final doc = await _usersCollection.doc(userId).get();
  if (doc.exists) {
    final data = doc.data() as Map<String, dynamic>;
    return List<String>.from(data['serviceIds'] ?? []);
  }
  return [];
}

Stream<List<String>> get providerServiceIdsStream => _usersCollection
    .doc(userId)
    .snapshots()
    .map((doc) {
      if (!doc.exists) return <String>[];
      final data = doc.data() as Map<String, dynamic>;
      return List<String>.from(data['serviceIds'] ?? []);
    });
}
