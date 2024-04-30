import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/admin_model.dart';

class AdminService {
  //initialize Firebase Firestore and Firebase Auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Set the admin data in the Firestore database.
  /// Takes an [admin] object and sets it in the 'admins' collection with the document ID '18'.
  Future<void> setAdmin(admin) async {
    try {
      await _firestore.collection('admins').doc('18').set(admin.toJson());
    } catch (e) {
      print('Error setting admin: $e');
    }
  }

  /// Sign in an admin with the provided [email] and [password].
  /// Returns an [AdminModel] object if the sign-in is successful, otherwise returns null.
  Future<AdminModel?> signInWithEmailAndPassword(
      BuildContext context, AdminModel adminModel) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: adminModel.email.toString(),
        password: adminModel.password,
      );
      // debugPrint('User: ${userCredential.user}');
      User? user = userCredential.user;
      String id = user?.uid ?? '';
      String userEmail = user?.email ?? '';
      return AdminModel(
        id: id,
        email: userEmail,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        default:
          errorMessage = e.code.toString();
      }
      
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: errorMessage,
        btnOkOnPress: () {},
      ).show();
      return null;
    }
  }

  // Sign Out 
  Future<AdminModel?> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      return null;
    } catch (e) {
      debugPrint('Error signing out: $e');
      rethrow;
    }
  }
}
