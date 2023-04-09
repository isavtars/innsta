import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/darktheme.dart';
import 'screen/register_screen.dart';

import 'utils/thems.dart';
//firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeChange(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChange>(
      builder: (context, themdatap, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "instagram clone",
          theme: themdatap.darkTheme ? kLightThems : kdarkThems,
          // home: const ResponsiveLayout(
          //   mobileScreenLayout: MobileScreenLayout(),
          //   webScreenLayout: WebScreenLayout(),
          // ),
          home: const RegisterScreen(),
        );
      },
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 54),
            child: Column(children: [
              const Text("heloo bibek"),
              Consumer<ThemeChange>(
                builder: (context, themedataValue, child) {
                  return Switch(
                      value: themedataValue.darkTheme,
                      onChanged: (value) {
                        themedataValue.toggleTheme();
                      });
                },
              )
            ])));
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Login and Signup Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isObscure = true;
//   final _auth = FirebaseAuth.instance;

//   void _toggleObscure() {
//     setState(() {
//       _isObscure = !_isObscure;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset('assets/images/flubase.png'),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     filled: true,
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     filled: true,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscure ? Icons.visibility_off : Icons.visibility,
//                         color: _isObscure ? Colors.grey : Colors.blue,
//                       ),
//                       onPressed: _toggleObscure,
//                     ),
//                   ),
//                   obscureText: _isObscure,
//                 ),
//                 const SizedBox(height: 12.0),
//                 ElevatedButton(
//                   child: const Text('Login'),
//                   onPressed: () async {
//                     try {
//                       final userCredential =
//                           await _auth.signInWithEmailAndPassword(
//                               email: _emailController.text.trim(),
//                               password: _passwordController.text.trim());
//                       if (userCredential.user != null) {
//                         // Login successful
//                         print('Welcome $_emailController');
//                       }
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'user-not-found') {
//                         print('No user found for that email.');
//                       } else if (e.code == 'wrong-password') {
//                         print('Wrong password provided for that user.');
//                       }
//                     }
//                   },
//                 ),
//                 TextButton(
//                   child: const Text(
//                     'Create an account',
//                     style: TextStyle(decoration: TextDecoration.underline),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SignUpPage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isObscure = true;
//   final _auth = FirebaseAuth.instance;

//   void _toggleObscure() {
//     setState(() {
//       _isObscure = !_isObscure;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Image.asset('assets/images/flubase.png'),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     filled: true,
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     filled: true,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isObscure ? Icons.visibility_off : Icons.visibility,
//                         color: _isObscure ? Colors.grey : Colors.blue,
//                       ),
//                       onPressed: _toggleObscure,
//                     ),
//                   ),
//                   obscureText: _isObscure,
//                 ),
//                 const SizedBox(height: 12.0),
//                 ElevatedButton(
//                   child: const Text('Create Account'),
//                   onPressed: () async {
//                     try {
//                       final userCredential =
//                           await _auth.createUserWithEmailAndPassword(
//                               email: _emailController.text.trim(),
//                               password: _passwordController.text.trim());
//                       if (userCredential.user != null) {
//                         // Account created successfully
//                       }
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'weak-password') {
//                         print('The password provided is too weak.');
//                       } else if (e.code == 'email-already-in-use') {
//                         print('The account already exists for that email.');
//                       }
//                     }
//                   },
//                 ),
//                 TextButton(
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(decoration: TextDecoration.underline),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
