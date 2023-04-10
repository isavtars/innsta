import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innsta/resources/auth_methods.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";

  @override
  void initState() {
    userName();
    super.initState();
  }

  //get user name from fireStore
  void userName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    debugPrint(
        " the user name is ${(snap.data() as Map<String, dynamic>)['username']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(21.0),
        child: Center(
            child: Column(
          children: [
            const Text("mobile Screen"),
            MaterialButton(
                onPressed: () async {
                  await AuthMethods().logOut();
                },
                child: const Icon(Icons.logout))
          ],
        )),
      ),
    );
  }
}
