import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_style.dart';

// ignore: must_be_immutable
class AppTextButton extends StatefulWidget {
  void Function()? onPressed;
  String buttonString;
  bool buttonColor;
  Size size;
  bool transparent;
  AppTextButton(
      {this.buttonColor = false,
      this.transparent = true,
      required this.buttonString,
      required this.onPressed,
      required this.size,
      Key? key})
      : super(key: key);

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  @override
  Widget build(BuildContext context) {
    // double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: Text(widget.buttonString, style: AppTextStyle.buttonTextStyle),
      style: OutlinedButton.styleFrom(
        // shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: widget.size,
        // Size(_screenWidth * 0.72, _screenHeight * 0.054),
        backgroundColor: widget.buttonColor
            ? AppColor.greyBlueColor
            : widget.transparent
                ? Colors.transparent
                : AppColor.greyColor,
        side: const BorderSide(color: AppColor.whiteColor, width: 1),
      ),
    );
  }
}
