import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/utils/app_style.dart';
import 'package:wired_social/widgets/circle.dart';

// ignore: must_be_immutable
class ListTileMessageClass extends StatefulWidget {
  void Function()? onTap;
  String networkImage;
  String title;
  String subTitile;
  ListTileMessageClass(
      {required this.networkImage,
      required this.title,
      required this.subTitile,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  State<ListTileMessageClass> createState() => _ListTileMessageClassState();
}

class _ListTileMessageClassState extends State<ListTileMessageClass> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    // double _screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              StoryWidget(imageUrl: widget.networkImage),
              SizedBox(
                width: _screenWidth * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title.trim(),
                    style: AppTextStyle.listTileFont,
                  ),
                  Text(widget.subTitile),
                ],
              ),
              const Spacer(),
              Column(
                children: const [
                  Text(AppStrings.appName),
                ],
              ),
            ]),
      ),
    );
  }
}
