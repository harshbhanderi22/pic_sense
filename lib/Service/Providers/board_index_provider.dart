import 'package:flutter/material.dart';

class BoardIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get getIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    //print("new index is $index");
    notifyListeners();
  }

  Color getButtonColor() {
    switch (_currentIndex) {
      case 0:
        return Colors.blue;

      case 1:
        return Colors.lightBlueAccent;

      case 2:
        return Colors.blueGrey;
    }
    return Colors.blue;
  }
}
