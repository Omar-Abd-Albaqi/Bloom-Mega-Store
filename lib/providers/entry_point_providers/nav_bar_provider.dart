import 'package:flutter/material.dart';
class NavBarProvider with ChangeNotifier{
  int index = 0;
  setIndex(int newIndex){
    index = newIndex;
    notifyListeners();
  }
}