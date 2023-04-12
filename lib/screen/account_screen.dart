import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/darktheme.dart';
import '../resources/auth_methods.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ThemeChange>(builder: (context, thems, child) {
      return Column(
        children: [
          const Placeholder(),
          MaterialButton(
            onPressed: () {
              AuthMethods().logOut();
            },
            child: const Icon(Icons.logout_outlined),
          ),
          Switch(
              value: thems.darkTheme,
              onChanged: (bool value) {
                thems.toggleTheme();
              })
        ],
      );
    }));
  }
}
