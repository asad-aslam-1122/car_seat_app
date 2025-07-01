import 'package:flutter/material.dart';

import '../../../global/constant/enums.dart';

class PasswordStateProvider with ChangeNotifier {
  List<PasswordStates> passwordStateList = [
    PasswordStates.hide,
    PasswordStates.hide,
    PasswordStates.hide,
  ];

  void update() {
    notifyListeners();
  }
}
