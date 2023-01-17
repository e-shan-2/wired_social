import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_style.dart';

// ignore: must_be_immutable
class AppTextFormField extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  bool obscureText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  Widget? icon;
  Widget? suffixIcon;
  AppTextFormField(
      {required this.labelText,
      this.icon,
      this.obscureText = false,
      this.suffixIcon,
      this.onChanged,
      required this.controller,
      this.validator,
      Key? key})
      : super(key: key);

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: TextInputAction.next,
      minLines: widget.obscureText ? 1 : 1,
      maxLines: widget.obscureText ? 1 : 8,
      decoration: InputDecoration(
        hintText: widget.labelText,
        hintStyle: AppTextStyle.buttonTextStyle
            .copyWith(color: AppColor.greyColor, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.suffixIcon,
      ),
      obscureText: widget.obscureText,
    );
  }
}
