import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_style.dart';

// ignore: must_be_immutable
class SettingsRow extends StatefulWidget {
  String image;
  String title;
  bool value;
  void Function()? onTap;
    
  SettingsRow({
    this.value=false,
    this.onTap, required this.title, required this.image, Key? key})
      : super(key: key);

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Image.asset(widget.image),
          SizedBox(
            width: _screenWidth * 0.04,
          ),
          Text(
            widget.title,
            style: widget.value ?AppTextStyle.settingsStyle.copyWith(color: AppColor.redColour):AppTextStyle.settingsStyle,
          )
        ],
      ),
    );
  }
}
