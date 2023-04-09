import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';
import '../widgets/inpurttex_feilds.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 69,
                child: Image.asset(
                  "assets/images/lightlogo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    maxRadius: 62,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/113200845?s=96&v=4"),
                  ),
                  Positioned(
                      bottom: -7,
                      left: 80,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo_camera,
                          size: 32,
                          color: kDarkBackGroundColor,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputTextFeilds(
                        hinttext: "Enter your usernames",
                        textEditingController: _usernameController,
                        textInputType: TextInputType.text,
                        isPass: false,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFeilds(
                        hinttext: "Enter your Email",
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFeilds(
                        hinttext: "Enter your password ",
                        textEditingController: _passwordController,
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputTextFeilds(
                        hinttext: "Enter your bio",
                        textEditingController: _bioController,
                        textInputType: TextInputType.text,
                        isPass: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ElevatedButton(
                          onPressed: () async {
                            String res = await AuthMethods().signUpUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                                username: _usernameController.text,
                                bio: _bioController.text);

                            debugPrint(res);
                          },
                          child: const Text("sign in")),

                      // Customebuttions(
                      //   buttontext: "Signup",
                      //   onpressed: () async {

                      //   },
                      // ),
                      const SizedBox(
                        height: 23,
                      ),
                      SizedBox(
                        height: 38,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: kJakartaHeading4.copyWith(
                                    fontSize: SizeConfig.blockSizeHorizontal! *
                                        kHeading4),
                              ),
                              Text(
                                "signin",
                                style: kJakartaHeading4.copyWith(
                                    color: kPrimarybackGround,
                                    fontSize: SizeConfig.blockSizeHorizontal! *
                                        kHeading4),
                              )
                            ]),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
