import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceAuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    bool _isLoading=false;
    bool get isLoading=>_isLoading;

    void _setLoading(bool value) {
      _isLoading = value;
      notifyListeners();
  }


  Future<void> loginAccount(String email, String password) async {
    try {
      _setLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
         await saveUserLoggedIn();

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception("Something went wrong");
    }
    finally{
      _setLoading(false);
    }
  }

  // Future<UserCredential> signUpAccount(String email, String password) async {
  //   try {
  //     _setLoading(true);
  //     final UserCredential cred =
  //         await auth.createUserWithEmailAndPassword(email: email, password: password);            
  //     return cred;
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e.message);
  //   } catch (_) {
  //     throw Exception("Something went wrong");
  //   }
  //   finally{
  //     _setLoading(false);
  //   }
  // }

    Future<UserCredential> signUpAccount(String email, String password) async {
    try {
      _setLoading(true);
      final UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
// await googleUser
 await _googleSignIn.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool('isLoggedIn') ?? false;
  }

  Future<void> saveUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('isLoggedIn', true);
    notifyListeners();
  }
//////////////
    Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }

  Future<User?> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await auth.signInWithCredential(credential);
    return userCredential.user;
  }

  // Future<void> resetPassword(String email) async {
  //   await auth.sendPasswordReset(email);
  // }
  Future<void> resetPassword(String email) async {
  try {
    await auth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    throw Exception(e.message);
  } catch (_) {
    throw Exception("Something went wrong");
  }
}



// Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   if (googleUser == null) {
//     throw Exception('Google Sign-In aborted');
//   }

//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return await auth.signInWithCredential(credential);
// }

   Future<UserCredential> signInWithGoogle() async {
    try {
      _setLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign-In aborted');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await auth.signInWithCredential(credential);
    } finally {
      _setLoading(false);
    }
  }



  // Future<void> signOutGoogle() async {
  //   try {
  //     await _googleSignIn.signOut();
  //     await _auth.signOut();
  //   } catch (e) {
  //     print("Sign-out Error: $e");
  //   }
  // }

}
