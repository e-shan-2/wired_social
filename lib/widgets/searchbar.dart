import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';
import 'package:wired_social/utils/app_style.dart';

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  String title;
  void Function(String)? onChanged;
  TextEditingController controller;
  SearchBar(
      {required this.controller, this.onChanged, required this.title, Key? key})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextFormField(
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.title,
          hintStyle: AppTextStyle.buttonTextStyle
              .copyWith(color: AppColor.greyColor, fontSize: 10),
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
        ),
      ),
    );
  }
}
