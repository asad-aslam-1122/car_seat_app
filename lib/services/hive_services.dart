import 'dart:developer';

import 'package:car_seat/feature/user/data/model/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../feature/global/constant/constants.dart';
import '../feature/global/constant/enums.dart';
import '../feature/user/presentation/provider/base_pages_section_provider.dart';

class HiveDb {
  static final _hive = Hive.box("showcase");

  static Future<void> setShowCase(
      bool isShowCase, ShowCasePages showCasePage) async {
    switch (showCasePage) {
      case ShowCasePages.home:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseHome}");
          Constants.isShowCaseHome = isShowCase;
          _hive.put("isShowCaseHome", isShowCase);
          break;
        }
      case ShowCasePages.alert:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseAlert}");
          Constants.isShowCaseAlert = isShowCase;
          _hive.put("isShowCaseAlert", isShowCase);
          break;
        }
      case ShowCasePages.sos:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseSOS}");
          Constants.isShowCaseSOS = isShowCase;
          _hive.put("isShowCaseSOS", isShowCase);
          break;
        }

      case ShowCasePages.manage:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseManage}");
          Constants.isShowCaseManage = isShowCase;
          _hive.put("isShowCaseManage", isShowCase);
          break;
        }

      case ShowCasePages.profileSettings:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseProfile}");
          Constants.isShowCaseProfile = isShowCase;
          _hive.put("isShowCaseProfile", isShowCase);
          break;
        }

      case ShowCasePages.emergency:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseEmergency}");
          Constants.isShowCaseEmergency = isShowCase;
          _hive.put("isShowCaseEmergency", isShowCase);
          break;
        }

      case ShowCasePages.biometric:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseBiometric}");
          Constants.isShowCaseBiometric = isShowCase;
          _hive.put("isShowCaseBiometric", isShowCase);
          break;
        }

      case ShowCasePages.batteryManaging:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseBattery}");
          Constants.isShowCaseBattery = isShowCase;
          _hive.put("isShowCaseBattery", isShowCase);
          break;
        }

      case ShowCasePages.themeCustomization:
        {
          log("____Constants.isShowCase:${Constants.isShowCaseTheme}");
          Constants.isShowCaseTheme = isShowCase;
          _hive.put("isShowCaseTheme", isShowCase);
          break;
        }

      case ShowCasePages.preferences:
        {
          Constants.isShowCasePreferences = isShowCase;
          log("____Constants.isShowCase:${Constants.isShowCasePreferences}");
          _hive.put("isShowCasePreferences", isShowCase);
          break;
        }
      default:
        print('Invalid day');
    }
  }

  static Future<void> setAllShowCaseValue(bool isShowCase) async {
    // Home Page
    Constants.isShowCaseHome = isShowCase;

    // Alert Page
    Constants.isShowCaseAlert = isShowCase;

    // SOS Page
    Constants.isShowCaseSOS = isShowCase;

    // Manage Page
    Constants.isShowCaseManage = isShowCase;

    // Profile Setting Page
    Constants.isShowCaseProfile = isShowCase;

    // Emergency Page
    Constants.isShowCaseEmergency = isShowCase;

    // Battery Manage Page
    Constants.isShowCaseBattery = isShowCase;

    // Theme Customization Page
    Constants.isShowCaseTheme = isShowCase;

    // Preferences Page
    Constants.isShowCasePreferences = isShowCase;

    // Biometric Page
    Constants.isShowCaseBiometric = isShowCase;
  }

  static getShowCase() async {
    Constants.isShowCaseHome = _hive.get("isShowCaseHome") ?? true;
    Constants.isShowCaseAlert = _hive.get("isShowCaseAlert") ?? true;
    Constants.isShowCaseSOS = _hive.get("isShowCaseSOS") ?? true;
    Constants.isShowCaseManage = _hive.get("isShowCaseManage") ?? true;
    Constants.isShowCaseProfile = _hive.get("isShowCaseProfile") ?? true;
    Constants.isShowCaseEmergency = _hive.get("isShowCaseEmergency") ?? true;
    Constants.isShowCaseBiometric = _hive.get("isShowCaseBiometric") ?? true;
    Constants.isShowCaseBattery = _hive.get("isShowCaseBattery") ?? true;
    Constants.isShowCaseTheme = _hive.get("isShowCaseTheme") ?? true;
    Constants.isShowCasePreferences =
        _hive.get("isShowCasePreferences") ?? true;
  }

  static Future<void> getTheme(BuildContext context) async {
    final BasePagesSectionProvider themeProvider =
        context.read<BasePagesSectionProvider>();

    var data = await Constants.themeBox.get(Constants.themeKey);

    var themeModeData =
        await Constants.themeModeBox.get(Constants.themeModeKey);

    if (data != null && themeModeData != null) {
      themeProvider.themeModel = ThemeModel.fromJson(data);
      themeProvider.selectedThemeMode = themeModeData;
      themeProvider.changeThemeModeFunc(
          context, themeProvider.selectedThemeMode);
      themeProvider.update();
    } else {
      themeProvider.themeModel = Constants.themeModelList.first;
      themeProvider.selectedThemeMode = 0;
    }
  }

  static Future<void> saveTheme(BuildContext context) async {
    ThemeModel theme = context.read<BasePagesSectionProvider>().themeModel;
    await Constants.themeBox.put(Constants.themeKey, theme.toJson());
  }

  static Future<void> saveThemeMode(BuildContext context) async {
    int themeModeValue =
        context.read<BasePagesSectionProvider>().selectedThemeMode;
    await Constants.themeModeBox.put(Constants.themeModeKey, themeModeValue);
  }
}
