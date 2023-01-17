import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_colour.dart';

// ignore: must_be_immutable
class StoryWidget extends StatefulWidget {
  String imageUrl;
  String title;
  bool text;
  StoryWidget(
      {this.text = false, this.title = "", required this.imageUrl, Key? key})
      : super(key: key);

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColor.greyBlueColor, shape: BoxShape.circle),
            margin: const EdgeInsets.all(9),
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  maxRadius: 25,
                  foregroundColor: AppColor.greyBlueColor,
                  foregroundImage: imageProvider,
                );
              },
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) {
                return const CircleAvatar(
                  maxRadius: 25,
                  foregroundColor: AppColor.greyBlueColor,
                  child: FittedBox(
                    child: Icon(
                      Icons.error,
                      color: AppColor.redColour,
                    ),
                  ),
                );
              },
              imageUrl: widget.imageUrl,
            ),
          ),
          widget.text
              ? Text(
                  widget.title.trim(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
        ],
      ),
    );
  }
}
