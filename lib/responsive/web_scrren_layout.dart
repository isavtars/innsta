import 'package:flutter/material.dart';
import 'package:innsta/provider/user_provider.dart';
import 'package:innsta/resources/auth_methods.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart' as model;

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
 

  @override
  Widget build(BuildContext context) {

  
    
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            MaterialButton(
              onPressed: () async {
                await AuthMethods().logOut();
                debugPrint("i clicked");
              },
              child: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }
}
