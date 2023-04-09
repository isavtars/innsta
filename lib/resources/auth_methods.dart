import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res = "something error occcures";
    // String res;
    debugPrint(email);
    debugPrint(password);

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register users
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        debugPrint(cred.user!.uid);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          "email": email,
          "pasword": password,
          "uid": cred.user!.uid,
          "bio": bio,
          "followers": [],
          "flowwing": [],
        });
        // await _firestore.collection('users').add({
        //   "email": email,
        //   "pasword": password,
        //   "uid": cred.user!.uid,
        //   "bio": bio,
        //   "followers": [],
        //   "flowwing": [],
        // });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
