import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innsta/resources/auth_methods.dart';
import 'package:innsta/utils/utils.dart';

import 'package:provider/provider.dart';

import '../provider/darktheme.dart';
import '../responsive/mobile_scrrenlayou.dart';
import '../responsive/rewsponsive_layout.dart';
import '../responsive/web_scrren_layout.dart';
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

  bool _isLodaing = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLodaing = true;
    });
    String res = await AuthMethods().loginUsers(
        email: _emailController.text.trim(),
        password: _passwordController.text);

    if (res == "success") {
      setState(() {
        _isLodaing = false;
      });
      // Navigator.pushNamed(context, "/home");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ),
          (route) => false);
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLodaing = false;
    });
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
                    child: SvgPicture.asset("assets/svgimages/back.svg"),
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
                            buttontext: _isLodaing
                                ? const CircularProgressIndicator(
                                    color: kWhite,
                                  )
                                : Text("Login",
                                    style: kJakartaBodyRegular.copyWith(
                                        color: kWhite,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                kBody)),
                            onpressed: loginUser,
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
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Don’t have an account?",
                              style: kJakartaHeading4.copyWith(
                                  color: kDarkBackGroundColor,
                                  fontSize: SizeConfig.blockSizeHorizontal! *
                                      kHeading4),
                            ),
                            TextSpan(
                                text: " signup",
                                style: kJakartaHeading4.copyWith(
                                  color: kPrimarybackGround,
                                  fontSize: SizeConfig.blockSizeHorizontal! *
                                      kHeading4,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, "/signup");
                                  })
                          ]))
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
