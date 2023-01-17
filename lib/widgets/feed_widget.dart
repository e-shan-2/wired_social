import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/list_tile.dart';

// ignore: must_be_immutable
class NewsFeedWidget extends StatefulWidget {
  String url;
  String titile;
  NewsFeedWidget({required this.titile, required this.url, Key? key})
      : super(key: key);

  @override
  State<NewsFeedWidget> createState() => _NewsFeedWidgetState();
}

class _NewsFeedWidgetState extends State<NewsFeedWidget> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    // double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTileMessageClass(
              networkImage: widget.url, title: widget.titile, subTitile: ""),
          CachedNetworkImage(
            height: _screenHeight * 0.3,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            imageUrl: widget.url,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              children: const [
                Icon(
                  Icons.favorite_outline_outlined,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.chat_bubble_outline_rounded),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.near_me_outlined)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(AppStrings.viewAllString),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
      decoration:
          const BoxDecoration(shape: BoxShape.rectangle, border: Border()),
    );
  }
}
