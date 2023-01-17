import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wired_social/provider/file_provider.dart';

import 'package:wired_social/utils/app_string.dart';
import 'package:wired_social/widgets/text_button.dart';

// ignore: must_be_immutable
class ImagePickerClass extends StatefulWidget {

  void Function() onPressedGallery;
  bool loading;
  ImagePickerClass(
      {this.loading = false,
      required this.onPressedGallery,
   
      Key? key})
      : super(key: key);

  @override
  State<ImagePickerClass> createState() => _ImagePickerClassState();
}

bool _data = false;

class _ImagePickerClassState extends State<ImagePickerClass> {
  @override
  void didChangeDependencies() {
    _data = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    double _screenWidth = MediaQuery.of(context).size.width;
    return Consumer<FileProvider>(
      builder: (context, _fileProvider, child) {
        return _data
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.transparent,
                child: const Center(child: CircularProgressIndicator()))
            : AlertDialog(
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(AppStrings.chooseImage),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextButton(
                        buttonColor: true,
                        buttonString: AppStrings.gallery,
                        onPressed: () async {
                          setState(() {
                            _data = true;
                          });
                          widget.onPressedGallery();
                        },
                        size: Size(_screenWidth * 0.25, _screenHeight * 0.05))
                  ]));
      },
    );
  }
}
