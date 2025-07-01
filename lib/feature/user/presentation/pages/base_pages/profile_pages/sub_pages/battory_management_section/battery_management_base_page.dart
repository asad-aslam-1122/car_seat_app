import 'dart:async';

import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/custom_switch_button.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/customize_theme/customize_theme_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../services/hive_services.dart';
import '../../../../../../../global/constant/enums.dart';
import '../../../../../../data/model/battery_model.dart';

class BatteryManagementBasePage extends StatefulWidget {
  static String route = "/BatteryManagementBasePage";
  const BatteryManagementBasePage({super.key});

  @override
  State<BatteryManagementBasePage> createState() =>
      _BatteryManagementBasePageState();
}

class _BatteryManagementBasePageState extends State<BatteryManagementBasePage> {
  final GlobalKey globalKey1 = GlobalKey();

  late Timer _timer;
  double batteryValue = 100;
  int indexValue = 0;
  List<BatteryModel> batteryModelList = [
    BatteryModel(
        color: R.appColors.greenColor,
        batteryImg: R.appImages.goodBatteryIcon,
        batteryValue: "80%",
        batteryHealth: "good"),
    BatteryModel(
        color: R.appColors.lemonColor,
        batteryImg: R.appImages.mediumBatteryIcon,
        batteryValue: "30%",
        batteryHealth: "medium"),
    BatteryModel(
        color: R.appColors.red,
        batteryImg: R.appImages.lowBatteryIcon,
        batteryValue: "9%",
        batteryHealth: "low"),
  ];

  bool isNotifyBatteryLow = false;

  List<GlobalKey> globalKeyList = [];
  int currentShowCaseIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BasePagesSectionProvider provider =
          Provider.of<BasePagesSectionProvider>(context, listen: false);

      if (Constants.isShowCaseBattery) {
        globalKeyList = [globalKey1];
        setState(() {});

        Future.delayed(const Duration(milliseconds: 100), () {
          ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeColor, child) {
        return ShowCaseWidget(
          onStart: (index, wid) {
            if (index == (globalKeyList.length - 1)) {
              currentShowCaseIndex = int.parse("$index");
              setState(() {});
            }
          },
          builder: (context) {
            themeColor.myContext = context;
            return SafeAreaWidget(
              child: Scaffold(
                backgroundColor: themeColor.themeModel.themeColor,
                appBar: AppBar(
                  backgroundColor: themeColor.themeModel.themeColor,
                  surfaceTintColor: themeColor.themeModel.themeColor,
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: R.appColors.white,
                      )),
                  title: Text(
                    "battery_management_".L(),
                    style: R.textStyles.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: R.appColors.white),
                  ),
                ),
                body: Container(
                  height: 100.h,
                  width: 100.w,
                  padding: const EdgeInsets.all(20),
                  decoration: R.decoration.topRadius(
                      radius: 30, backgroundColor: R.appColors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "manage_battery".L(),
                        style: R.textStyles.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "keep_track_of_your_battery_health_with_ease".L(),
                        style: R.textStyles.poppins(
                            color: R.appColors.textGreyColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyShowCaseWidget(
                          myContext: themeColor.myContext!,
                          globalKey: globalKey1,
                          showCasePages: ShowCasePages.batteryManaging,
                          hideBackButton: true,
                          showArrowLeftSide: false,
                          currentGuideIndex: 15,
                          title: 'track_battery',
                          targetBorderRadius: 10,
                          isDismiss: false,
                          onOkTap: () async {
                            if (currentShowCaseIndex ==
                                (globalKeyList.length - 1)) {
                              ShowCaseWidget.of(themeColor.myContext!)
                                  .dismiss();
                              await HiveDb.setShowCase(
                                  false, ShowCasePages.batteryManaging);
                              setState(() {});
                            }
                            Get.offAndToNamed(CustomizeThemePage.route);
                            ShowCaseWidget.of(themeColor.myContext!).next();
                          },
                          onBarrierTab: () async {
                            if (currentShowCaseIndex ==
                                (globalKeyList.length - 1)) {
                              ShowCaseWidget.of(themeColor.myContext!)
                                  .dismiss();
                              await HiveDb.setShowCase(
                                  false, ShowCasePages.batteryManaging);
                              setState(() {});
                            }
                            Get.offAndToNamed(CustomizeThemePage.route);
                            ShowCaseWidget.of(themeColor.myContext!).next();
                          },
                          description:
                              'effortlessly_monitor_your_devices_battery_health',
                          widget: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: R.decoration.outLineDecoration(
                                radius: 10,
                                backgroundColor: R.appColors.white,
                                borderColor:
                                    batteryModelList[indexValue].color),
                            child: ListTile(
                              leading: SizedBox(
                                height: 100,
                                width: 50,
                                child: Stack(
                                  children: [
                                    SpinKitDoubleBounce(
                                      color: batteryModelList[indexValue]
                                          .color
                                          .withOpacity(0.005),
                                      duration: const Duration(seconds: 5),
                                    ),
                                    Center(
                                      child: Image.asset(
                                        batteryModelList[indexValue].batteryImg,
                                        scale: 5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              title: RichText(
                                  text: TextSpan(
                                      style: R.textStyles.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: R.appColors.textGreyColor),
                                      children: [
                                    TextSpan(
                                      text: "battery_health_".L(),
                                    ),
                                    TextSpan(
                                        text: batteryModelList[indexValue]
                                            .batteryHealth
                                            .L(),
                                        style: R.textStyles.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13.sp,
                                            color: batteryModelList[indexValue]
                                                .color))
                                  ])),
                              trailing: Text(
                                  batteryModelList[indexValue].batteryValue,
                                  style: R.textStyles.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color:
                                          batteryModelList[indexValue].color)),
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "notifications_preferences_".L(),
                        style: R.textStyles.poppins(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "notify_when_battery_is_below_20_".L(),
                            style: R.textStyles.poppins(
                                color: R.appColors.textGreyColor,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomSwitch(
                              value: isNotifyBatteryLow,
                              onChanged: (newValue) {
                                isNotifyBatteryLow = newValue;
                                setState(() {});
                              },
                              color: themeColor.themeModel.themeColor)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  changeBatteryValue() {
    const oneSec = Duration(milliseconds: 200);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (batteryValue == 0) {
          setState(() {
            timer.cancel();
          });
        } else if (batteryValue == 100) {
          indexValue = 0;
        } else if (batteryValue == 70) {
          indexValue = 1;
        } else if (batteryValue == 40) {
          indexValue = 2;
        }
        indexValue = indexValue;
        batteryValue--;
        setState(() {});
      },
    );
  }
}
