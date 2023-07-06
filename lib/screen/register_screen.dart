import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:innsta/utils/utils.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/input_text_fields.dart';

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
  Uint8List? image;
  bool _isLodaing = false;

  void selectedImages() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signUpUsers() async {
    setState(() {
      _isLodaing = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: image!);

    debugPrint(res);
    setState(() {
      _isLodaing = false;
    });
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);
    }
  }

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
          child: Column(children: [
            SizedBox(
                height: 69,
                child: SvgPicture.asset("assets/svgimages/back.svg")),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(image!),
                      )
                    : const CircleAvatar(
                        maxRadius: 62,
                        foregroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/97216927?v=4"),
                      ),
                Positioned(
                    bottom: -7,
                    left: 80,
                    child: IconButton(
                      onPressed: selectedImages,
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
                  InputTextFields(
                    hinttext: "Enter your Username",
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFields(
                    hinttext: "Enter your Email",
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFields(
                    hinttext: "Enter your Password",
                    textEditingController: _passwordController,
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFields(
                    hinttext: "Enter your bio",
                    textEditingController: _bioController,
                    textInputType: TextInputType.text,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButtons(
                      buttontext: _isLodaing
                          ? const CircularProgressIndicator(
                              color: kWhite,
                            )
                          : Text(
                              'Sign Up',
                              style: kJakartaHeading3.copyWith(
                                color: kWhite,
                                fontSize:
                                    SizeConfig.blockSizeHorizontal! * kHeading4,
                              ),
                            ),
                      onpressed: signUpUsers),
                  const SizedBox(
                    height: 23,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Already have an account ?",
                      style: kJakartaHeading4.copyWith(
                          color: kDarkBackGroundColor,
                          fontSize:
                              SizeConfig.blockSizeHorizontal! * kHeading4),
                    ),
                    TextSpan(
                        text: " Login",
                        style: kJakartaHeading4.copyWith(
                          color: kPrimarybackGround,
                          fontSize: SizeConfig.blockSizeHorizontal! * kHeading4,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/login");
                          })
                  ]))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
