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
  void initState() {
    addDatta();
    super.initState();
  }

  addDatta() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user.username),
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
