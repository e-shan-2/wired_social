import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool onchanging(List<TextEditingController> controller) {
    for (int i = 0; i < controller.length; i++) {
      if (controller[i].text.isEmpty) {
        notifyListeners();
        return false;
      }
    }
    notifyListeners();
    return true;
  }

  bool ontoggle(bool obscure) {
    obscure = !obscure;
    notifyListeners();
    return obscure;
  }
}
