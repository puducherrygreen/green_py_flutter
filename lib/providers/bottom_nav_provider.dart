import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  setIndex(int indexVal) {
    currentIndex = indexVal;
    notifyListeners();
  }
}
