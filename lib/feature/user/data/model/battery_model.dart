import 'package:flutter/material.dart';

class BatteryModel {
  Color color;
  String batteryValue;
  String batteryHealth;
  String batteryImg;

  BatteryModel(
      {required this.color,
      required this.batteryValue,
      required this.batteryImg,
      required this.batteryHealth});
}
