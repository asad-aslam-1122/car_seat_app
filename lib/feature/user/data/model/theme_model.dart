import 'package:flutter/material.dart';

class ThemeModel {
  Color themeColor;
  String themeTitle;
  String id;

  ThemeModel(
      {required this.themeColor, required this.themeTitle, required this.id});

  factory ThemeModel.fromJson(Map<dynamic, dynamic> json) {
    return ThemeModel(
      themeTitle: json['themeTitle'],
      themeColor: Color(json['themeColor'] as int),
      id: json['id'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'themeTitle': themeTitle,
      'themeColor': themeColor.value,
      'id': id,
    };
  }
}
