import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/darktheme.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';
import '../widgets/custome_buttons.dart';
import '../widgets/inpurttex_feilds.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Consumer<ThemeChange>(
        builder: (context, themevalue, child) {
          return Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 60),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 76,
                  ),
                  SizedBox(
                    height: 79,
                    child: Image.asset(
                      themevalue.darkTheme
                          ? "assets/images/lightlogo.png"
                          : "assets/images/darklogo.png",
                      fit: BoxFit.cover,
                    ),
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
                            hinttext: "email",
                            textEditingController: _emailController,
                            textInputType: TextInputType.emailAddress,
                            isPass: false,
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          InputTextFeilds(
                            hinttext: "password",
                            textEditingController: _passwordController,
                            textInputType: TextInputType.text,
                            isPass: true,
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "forgget password??",
                              style: kJakartaBodyRegular.copyWith(
                                  color: kPrimarybackGround,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal! * kBody),
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Customebuttions(
                            buttontext: "LOGIN",
                            onpressed: () {},
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 32,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Logi in with  Gooogle",
                                    style: kJakartaBodyBold.copyWith(
                                        color: kPrimarybackGround,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                kHeading4),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Center(
                            child: Text(
                              "OR",
                              style: kJakartaHeading4.copyWith(
                                  fontSize: SizeConfig.blockSizeHorizontal! *
                                      kHeading4),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                            height: 46,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don’t have an account?",
                                    style: kJakartaHeading4.copyWith(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                kHeading4),
                                  ),
                                  Text(
                                    "signin",
                                    style: kJakartaHeading4.copyWith(
                                        color: kPrimarybackGround,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                kHeading4),
                                  )
                                ]),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
