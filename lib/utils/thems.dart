import 'package:flutter/material.dart';

import 'app_styles.dart';

final kdarkThems = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: kDarkBackGroundColor,
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)));

final kLightThems = ThemeData.light().copyWith(
    scaffoldBackgroundColor: kDarkBackGroundColor,
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)));
