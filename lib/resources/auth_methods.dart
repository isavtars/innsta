import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

import '../model/user_model.dart' as model;
import 'storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // get user details Reads
  Future<model.User> getUserDetails() async {
    //this is firebase Users
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "something error occcures";
    // String res;
    debugPrint(email);
    debugPrint(password);

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        debugPrint(cred.user!.uid);

        String photurl =
            await StorageMehods().uplodaImages('profilePicture', file, false);

        model.User user = model.User(
            username: username,
            email: email,
            uid: cred.user!.uid,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photurl);

        //to  insset in firebase storage create add
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "please enter all feilds";
      }
      //u can definatily do this
      // } on FirebaseAuthException catch (err) {
      //   if (err.code == "invalid-email") {
      //     res = "the email is badly formatted";
      //   }
      //   else if(err.code == "weak-password"){
      //       res = "the email is badly formatted";
      //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login for the users

  Future<String> loginUsers({
    required String email,
    required String password,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "success";
      } else {
        res = "please  enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //reset password
  Future<String> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    String res = "Something went wrong";
    try {
      if (email.isNotEmpty) {
        // Check if the user exists
        var user =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (user.isNotEmpty) {
          // User exists, send password reset link
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          res = "success";
        } else {
          // User does not exist, navigate to register screen
          res = "nouser";
          Navigator.pushNamed(context, '/signup');
        }
      } else {
        res = "Please enter your email";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//sign in with google
  Future<String> signInWithGoogle() async {
    String res = "Something went wrong";

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        // Check if the user already exists in Firestore
        final DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (!snapshot.exists) {
          // User is signing in for the first time, create a new user document
          model.User newUser = model.User(
            username: user.displayName ?? '',
            email: user.email ?? '',
            uid: user.uid,
            bio: '',
            followers: [],
            following: [],
            photoUrl: user.photoURL ?? '',
          );

          await _firestore
              .collection('users')
              .doc(user.uid)
              .set(newUser.toJson());
        }
        res = "success";
      } else {
        res = "Unable to sign in with Google";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  //logout

  Future<void> logOut() async {
    _auth.signOut();
  }
}
