import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:flutter/material.dart';

class OnBoardProvider extends ChangeNotifier {
  ContainerType containerType = ContainerType.languageContainer;
  String selectedLanguage = "english";
  int pageIndex = 0;

  void update() {
    notifyListeners();
  }
}
