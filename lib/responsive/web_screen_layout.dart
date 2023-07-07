import 'package:flutter/material.dart';
import 'package:instagram/resources/auth_methods.dart';

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
      body: Column(
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
    );
  }
}
