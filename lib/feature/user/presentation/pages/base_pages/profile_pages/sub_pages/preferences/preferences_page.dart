import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/custom_switch_button.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/prefrences_alert_widget.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:car_seat/services/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../data/model/preferences_model.dart';

class PreferencesPage extends StatefulWidget {
  static String route = "/PreferencesPage";
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool canExpand = true;

  final GlobalKey globalKey1 = GlobalKey();

  List<PreferencesModel> safetyAlert = [
    PreferencesModel(title: "pressure_alert", showMore: true, subItems: [
      SubItems("severity_level", ["regular", "medium", "emergency"]),
      SubItems(
        "alert_tone",
        [
          "tone1",
          "tone2",
          "tone3",
          "tone4",
          "tone5",
          "tone6",
        ],
      ),
    ]),
    PreferencesModel(title: "temperature_alert", showMore: true, subItems: [
      SubItems("severity_level", ["regular", "medium", "emergency"]),
      SubItems(
        "alert_tone",
        [
          "tone1",
          "tone2",
          "tone3",
          "tone4",
          "tone5",
          "tone6",
        ],
      ),
    ]),
    PreferencesModel(title: "inactivity_alert", showMore: true, subItems: [
      SubItems("severity_level", ["regular", "medium", "emergency"]),
      SubItems(
        "alert_tone",
        [
          "tone1",
          "tone2",
          "tone3",
          "tone4",
          "tone5",
          "tone6",
        ],
      ),
    ]),
  ];

  List<PreferencesModel> deviceAndConnectivityAlert = [
    PreferencesModel(
        title: "device_connection_notification",
        showMore: true,
        subItems: [
          SubItems(
            "alert_tone",
            [
              "tone1",
              "tone2",
              "tone3",
              "tone4",
              "tone5",
              "tone6",
            ],
          ),
        ]),
    PreferencesModel(title: "battery_notification", showMore: true, subItems: [
      SubItems(
        "alert_tone",
        [
          "tone1",
          "tone2",
          "tone3",
          "tone4",
          "tone5",
          "tone6",
        ],
      ),
    ]),
    PreferencesModel(title: "inactivity_alert", showMore: true, subItems: []),
  ];

  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BasePagesSectionProvider provider =
          Provider.of<BasePagesSectionProvider>(context, listen: false);

      if (Constants.isShowCasePreferences) {
        globalKeyList = [globalKey1];
        setState(() {});

        Future.delayed(const Duration(milliseconds: 100), () {
          ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
        });
      }
    });
  }

  int currentShowCaseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeColor, child) {
        return ShowCaseWidget(
          builder: (showCaseContext) {
            themeColor.myContext = showCaseContext;
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
                    "preference".L(),
                    style: R.textStyles.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: R.appColors.white),
                  ),
                ),
                body: SafeArea(
                  child: Container(
                      height: 100.h,
                      padding: const EdgeInsets.all(20),
                      decoration: R.decoration.topRadius(
                          radius: 30, backgroundColor: R.appColors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GlobalWidgets.labelText(text: "safety_alert_"),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                if (index == 1) {
                                  return MyShowCaseWidget(
                                    showCasePages: ShowCasePages.preferences,
                                    myContext: themeColor.myContext!,
                                    globalKey: globalKey1,
                                    hideBackButton: true,
                                    currentGuideIndex: 18,
                                    title: 'alerts_preferences',
                                    targetBorderRadius: 10,
                                    isDismiss: true,
                                    onCloseFunc: () async {
                                      await HiveDb.setShowCase(
                                          false, ShowCasePages.preferences);
                                      setState(() {});
                                      ShowCaseWidget.of(themeColor.myContext!)
                                          .dismiss();
                                    },
                                    onOkTap: () async {
                                      ShowCaseWidget.of(themeColor.myContext!)
                                          .dismiss();
                                      await HiveDb.setShowCase(
                                          false, ShowCasePages.preferences);
                                      setState(() {});
                                    },
                                    onBarrierTab: () async {
                                      ShowCaseWidget.of(themeColor.myContext!)
                                          .dismiss();
                                      await HiveDb.setShowCase(
                                          false, ShowCasePages.preferences);
                                      setState(() {});
                                    },
                                    description:
                                        'set_your_alert_severity_level_and_tones_according_to_your_preferences',
                                    widget: IgnorePointer(
                                      ignoring: Constants.isShowCasePreferences,
                                      child: preferencesCard(
                                          preferencesList: safetyAlert[index],
                                          themeColor: themeColor),
                                    ),
                                  );
                                }

                                return preferencesCard(
                                    preferencesList: safetyAlert[index],
                                    themeColor: themeColor);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: safetyAlert.length,
                            ),
                            GlobalWidgets.labelText(
                                text: "device_and_conectivity_alerts_"),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                return preferencesCard(
                                    preferencesList:
                                        deviceAndConnectivityAlert[index],
                                    themeColor: themeColor);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: deviceAndConnectivityAlert.length,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Card preferencesCard(
      {required PreferencesModel preferencesList,
      required BasePagesSectionProvider themeColor}) {
    return Card(
      color: R.appColors.lightGreyColor,
      shadowColor: R.appColors.transparent,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  preferencesList.title.L(),
                  style: R.textStyles.poppins(
                    color: themeColor.isDarkTheme
                        ? R.appColors.white
                        : R.appColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                CustomSwitch(
                    value: preferencesList.showMore,
                    onChanged: (newValue) {
                      preferencesList.showMore = newValue;
                      setState(() {});
                    },
                    color: context
                        .read<BasePagesSectionProvider>()
                        .themeModel
                        .themeColor),
              ],
            ),
            if (preferencesList.showMore) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  preferencesList.subItems?.length ?? 0,
                  (innerIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            preferencesList.subItems?[innerIndex].title?.L() ??
                                "",
                            style: R.textStyles.poppins(
                                color: themeColor.isDarkTheme
                                    ? R.appColors.white
                                    : R.appColors.textGreyColor,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PreferenceAlertWidget(
                                      title: preferencesList
                                              .subItems?[innerIndex].title ??
                                          "",
                                      list: preferencesList
                                              .subItems?[innerIndex].subList ??
                                          []);
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  preferencesList
                                          .subItems?[innerIndex].subList?.first
                                          .L() ??
                                      "",
                                  style: R.textStyles.poppins(
                                      color: themeColor.isDarkTheme
                                          ? R.appColors.white
                                          : R.appColors.textGreyColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 12,
                                  color: themeColor.isDarkTheme
                                      ? R.appColors.white
                                      : R.appColors.textGreyColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
