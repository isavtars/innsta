import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/utils/utils.dart';

import 'package:provider/provider.dart';

import '../provider/darktheme.dart';
// import '../responsive/mobile_screen_layout.dart';
// import '../responsive/responsive_layout.dart';
// import '../responsive/web_screen_layout.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_text_fields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().resetPassword(
      email: _emailController.text.trim(),
    );

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
      showSnackBar(context, "Password reset email sent");
    } else {
      showSnackBar(context, "Something went wrong");
    }

    setState(() {
      isLoading = false;
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
                    child: SvgPicture.asset("assets/svgimages/w.svg"),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputTextFields(
                            icon: const Icon(
                              Icons.alternate_email,
                              color: Colors.grey,
                            ),
                            hinttext: "Email",
                            textEditingController: _emailController,
                            textInputType: TextInputType.emailAddress,
                            isPass: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            '*Password reset link will be sent to the email you provide',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtons(
                            buttontext: isLoading
                                ? const CircularProgressIndicator(
                                    color: kWhite,
                                  )
                                : Text("Reset",
                                    style: kJakartaBodyRegular.copyWith(
                                        color: kWhite,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                kBody)),
                            onpressed: resetPassword,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Back to Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
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
