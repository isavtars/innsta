import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:innsta/screen/login_screen.dart';
import 'package:provider/provider.dart';

import 'provider/darktheme.dart';
import 'responsive/mobile_scrrenlayou.dart';
import 'responsive/rewsponsive_layout.dart';
import 'responsive/web_scrren_layout.dart';
import 'screen/home_screen.dart';
import 'screen/register_screen.dart';
import 'provider/user_provider.dart';

import 'utils/thems.dart';
//firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDVhFEp-LT20aNfO7pEPD9FLnY0hWZ4NZE",
        appId: "1:356702458401:web:ec95043014385bed274960",
        messagingSenderId: "356702458401",
        projectId: "insta-clone-18103",
        storageBucket: "insta-clone-18103.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChange())
      ],
      child: Consumer<ThemeChange>(
        builder: (context, themdatap, child) {
          debugPrint('${themdatap.darkTheme}');

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "instagram clone",
            theme: themdatap.darkTheme ? kLightThems : kdarkThems,

            // initialRoute: "/login",
            routes: {
              "/home": (context) => const HomeScreen(),
              "/login": (context) => const LoginScreen(),
              "/signup": (context) => const RegisterScreen(),
            },
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  // Checking if the snapshot has any data or not
                  if (snapshot.hasData) {
                    // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                    return const ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }

                // means connection to future hasnt been made yet
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
