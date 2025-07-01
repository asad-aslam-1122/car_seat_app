import 'package:flutter/services.dart';

import '../bot_toast/zbot_toast.dart';

class PopScopeWidget {
  static DateTime? currentBackPressTime;

  static onPopInvokedWithResult(didPop, result) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      ZBotToast.showToastSuccess(
        message: "press_again_to_exit",
      );
      return false;
    }
    SystemNavigator.pop();
  }
}
