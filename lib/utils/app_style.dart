import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';

class AppTextStyle {
  static const TextStyle wiredTextStyle =
      TextStyle(fontSize: 24, color: AppColor.whiteColor, fontFamily: "Roboto");

  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor,
      fontFamily: "Poppins");

  static const TextStyle loginSignupTabBar = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      // color: AppColor.whiteColor,
      fontFamily: "Poppins");
  static const appBArTitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColor.gradientColour,
      fontFamily: "Poppins");
  static const listTileFont = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.gradientColour,
      fontFamily: "Poppins");

  static const messagebubble = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: "Poppins");
  static const settingsStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontFamily: "Poppins");
}
