import 'package:flutter/material.dart';

import '../utils/app_styles.dart';
import '../utils/size_config.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons(
      {super.key, required this.buttontext, required this.onpressed});

  final Widget buttontext;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 57,
        width: MediaQuery.of(context).size.width * 0.99,
        decoration: BoxDecoration(
            color: kPrimarybackGround, borderRadius: BorderRadius.circular(5)),
        child: Center(child: buttontext),
      ),
    );
  }
}
