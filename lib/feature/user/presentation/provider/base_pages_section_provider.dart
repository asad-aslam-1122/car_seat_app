import 'dart:async';

import 'package:car_seat/extentions/theme_extentions.dart';
import 'package:car_seat/feature/user/data/model/child_info_model.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/home_pages/home_base_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/resources.dart';
import '../../../global/constant/enums.dart';
import '../../data/model/contact_model.dart';
import '../../data/model/device_info_list_model.dart';
import '../../data/model/theme_model.dart';

class BasePagesSectionProvider extends ChangeNotifier {
  BuildContext? myContext;
  Widget currentPage = const HomeBasePages();
  int selectedBaseIndex = 0;
  bool isTempShowSwitchActive = true;
  AlertSectionOptions alertSectionOptions = AlertSectionOptions.alertOption;
  int selectedManageCateIndex = 0;
  bool isPopUpOpened = false;
  bool isDarkTheme = false;
  Timer? timer;
  List<DeviceInfoListModel> devicesList = [];
  List<ListTileModel> childrenList = [];
  List<ListTileModel> vehicleList = [];
  List<ContactModel> emergencyContactList = [];

  late TabController tabController;
  late TabController alertTabBarController;
  int selectedThemeMode = 0;

  bool bioMetricLogin = false;

  ManagingSectionOptions managingSectionOptions = ManagingSectionOptions.device;

  changeThemeModeFunc(BuildContext context, int index) {
    selectedThemeMode = index;
    switch (selectedThemeMode) {
      case 0:
        {
          if (timer != null) {
            timer!.cancel();
            timer = null;
          }
          isDarkTheme = false;
        }
      case 1:
        {
          if (timer != null) {
            timer!.cancel();
            timer = null;
          }
          isDarkTheme = true;
        }
      case 2:
        {
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            isDarkTheme = Get.context!.isPhoneDarkMode;
            updateColors();
          });
        }
    }
    updateColors();
  }

  updateColors() {
    R.appColors.black =
        isDarkTheme ? const Color(0xffFFFFFF) : const Color(0xff000000);
    R.appColors.white =
        isDarkTheme ? const Color(0xff000000) : const Color(0xffFFFFFF);
    R.appColors.textGreyColor =
        isDarkTheme ? const Color(0xffFFFFFF) : const Color(0xff686868);
    R.appColors.lightGreenColor =
        isDarkTheme ? const Color(0xffFFFFFF) : const Color(0xffD0F9E5);
    R.appColors.darkTextGreyColor = isDarkTheme
        ? const Color(0xffFFFFFF).withOpacity(.7)
        : const Color(0xff6B6B6B);
    update();
  }

  ThemeModel themeModel = ThemeModel(
      themeColor: R.appColors.defaultPrimaryColor,
      themeTitle: "default",
      id: "0");

  void update() {
    notifyListeners();
  }
}
