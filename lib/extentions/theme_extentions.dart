import 'package:flutter/cupertino.dart';

extension PhoneDarkMode on BuildContext {
  bool get isPhoneDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension ColorExtension on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2).toLowerCase()}';
  }
}
