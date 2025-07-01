import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/preferences/preferences_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:car_seat/services/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../global/constant/enums.dart';

class CustomizeThemePage extends StatefulWidget {
  static String route = "/CustomizeThemePage";
  const CustomizeThemePage({super.key});

  @override
  State<CustomizeThemePage> createState() => _CustomizeThemePageState();
}

class _CustomizeThemePageState extends State<CustomizeThemePage> {
  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();

  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BasePagesSectionProvider provider =
          Provider.of<BasePagesSectionProvider>(context, listen: false);

      if (Constants.isShowCaseTheme) {
        globalKeyList = [globalKey1, globalKey2];
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
      builder: (context, themeModelProvider, child) {
        return ShowCaseWidget(
          onStart: (index, wid) {
            if (index == (globalKeyList.length - 1)) {
              currentShowCaseIndex = int.parse("$index");
              setState(() {});
            }
          },
          builder: (context) {
            themeModelProvider.myContext = context;
            return SafeAreaWidget(
              child: Scaffold(
                backgroundColor: themeModelProvider.themeModel.themeColor,
                appBar: AppBar(
                  backgroundColor: themeModelProvider.themeModel.themeColor,
                  surfaceTintColor: themeModelProvider.themeModel.themeColor,
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
                    "theme_customization".L(),
                    style: R.textStyles.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: R.appColors.white),
                  ),
                ),
                body: SafeArea(
                  child: Container(
                      height: 100.h,
                      width: 100.w,
                      padding: const EdgeInsets.all(20),
                      decoration: R.decoration.topRadius(
                          radius: 30, backgroundColor: R.appColors.white),
                      child: Column(
                        children: [
                          MyShowCaseWidget(
                            showCasePages: ShowCasePages.themeCustomization,
                            myContext: themeModelProvider.myContext!,
                            globalKey: globalKey1,
                            hideBackButton: true,
                            currentGuideIndex: 16,
                            title: 'color_customization',
                            targetBorderRadius: 10,
                            isDismiss: false,
                            onOkTap: () async {
                              ShowCaseWidget.of(context).next();
                            },
                            description:
                                'change_your_apps_color_scheme_according_to_your_preference',
                            widget: IgnorePointer(
                              ignoring: Constants.isShowCaseTheme,
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 8,
                                shadowColor:
                                    R.appColors.black.withOpacity(0.28),
                                color: R.appColors.white,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "color".L(),
                                                style: R.textStyles.poppins(
                                                    color: R.appColors
                                                        .textGreyColor),
                                              ),
                                              Text(
                                                themeModelProvider
                                                    .themeModel.themeTitle
                                                    .L(),
                                                style: R.textStyles.poppins(
                                                    fontSize: 15.sp,
                                                    color: R.appColors
                                                        .textGreyColor),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(
                                            Constants.themeModelList.length,
                                            (index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  themeModelProvider
                                                          .themeModel =
                                                      Constants.themeModelList[
                                                          index];
                                                  themeModelProvider.update();
                                                  HiveDb.saveTheme(context);
                                                },
                                                child: Container(
                                                    decoration: R.decoration.circleShapeWithBorder(
                                                        borderColor: themeModelProvider
                                                                    .themeModel
                                                                    .themeTitle ==
                                                                Constants
                                                                    .themeModelList[
                                                                        index]
                                                                    .themeTitle
                                                            ? R.appColors
                                                                .iconsGreyColor
                                                            : R.appColors
                                                                .transparent),
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: R.decoration
                                                          .circleShapeWithShadow(
                                                              backgroundColor:
                                                                  Constants
                                                                      .themeModelList[
                                                                          index]
                                                                      .themeColor,
                                                              shadowColor: R
                                                                  .appColors
                                                                  .transparent),
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyShowCaseWidget(
                            showCasePages: ShowCasePages.themeCustomization,
                            myContext: themeModelProvider.myContext!,
                            globalKey: globalKey2,
                            currentGuideIndex: 17,
                            title: 'theme_customization',
                            targetBorderRadius: 10,
                            isDismiss: false,
                            onBackTap: () {
                              ShowCaseWidget.of(themeModelProvider.myContext!)
                                  .previous();
                            },
                            onOkTap: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length - 1)) {
                                ShowCaseWidget.of(themeModelProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.themeCustomization);
                                setState(() {});
                              }

                              Get.offAndToNamed(PreferencesPage.route);
                            },
                            onBarrierTab: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length - 1)) {
                                ShowCaseWidget.of(themeModelProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.themeCustomization);
                                setState(() {});
                              }
                              Get.offAndToNamed(PreferencesPage.route);
                            },
                            description:
                                'change_your_apps_theme_according_to_your_preference',
                            widget: IgnorePointer(
                              ignoring: Constants.isShowCaseTheme,
                              child: Card(
                                elevation: 8,
                                margin: EdgeInsets.zero,
                                shadowColor:
                                    R.appColors.black.withOpacity(0.28),
                                color: R.appColors.white,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "theme".L(),
                                            style: R.textStyles.poppins(
                                              color: R.appColors.textGreyColor,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                              Constants.themeModesList.length,
                                              (index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    themeModelProvider
                                                        .changeThemeModeFunc(
                                                            context, index);
                                                    HiveDb.saveThemeMode(
                                                        context);
                                                    setState(() {});
                                                    Get.forceAppUpdate();
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        Constants
                                                            .themeModesList[
                                                                index]
                                                            .subTitle,
                                                        height: 14.h,
                                                        width: 56,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3),
                                                        child: Text(
                                                          Constants
                                                              .themeModesList[
                                                                  index]
                                                              .title
                                                              .L(),
                                                          style: R.textStyles
                                                              .poppins(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: R
                                                                      .appColors
                                                                      .textGreyColor),
                                                        ),
                                                      ),
                                                      Container(
                                                          decoration: R
                                                              .decoration
                                                              .circleShapeWithBorder(
                                                                  borderColor: R
                                                                      .appColors
                                                                      .iconsGreyColor),
                                                          child: Container(
                                                            height: 22,
                                                            width: 22,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration: R.decoration.circleShapeWithShadow(
                                                                backgroundColor: themeModelProvider
                                                                            .selectedThemeMode ==
                                                                        index
                                                                    ? themeModelProvider
                                                                        .themeModel
                                                                        .themeColor
                                                                    : R.appColors
                                                                        .transparent,
                                                                shadowColor: R
                                                                    .appColors
                                                                    .transparent),
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
