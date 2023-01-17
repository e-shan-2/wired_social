import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {
  String? randomData;
  storeRandomData(String data) {
    randomData = data;
    notifyListeners();
  }

  String? picUrl;
  String storeUrl(String url) {
    picUrl = url;
    return picUrl!;
  }
}
