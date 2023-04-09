import 'package:flutter/material.dart';


import '../utils/app_styles.dart';
import '../utils/size_config.dart';

class Customebuttions extends StatelessWidget {
  const Customebuttions(
      {super.key, required this.buttontext, required this.onpressed});

  final String buttontext;
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
        child: Center(
            child: Text(
          buttontext,
          style: kjakartaHeading2.copyWith(
            color: kPrimarydarkText,
            fontSize: SizeConfig.blockSizeHorizontal! * kHeading4,
          ),
        )),
      ),
    );
  }
}
