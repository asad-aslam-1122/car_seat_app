import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/user/data/model/title_subtitle_model.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/battory_management_section/battery_management_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/biometric_setup_page/bio_metric_set_up_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/customize_theme/customize_theme_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/emergency_contacts/emergency_contact_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/preferences/preferences_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/settings/settings_base_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../services/hive_services.dart';
import '../../../../../global/constant/enums.dart';

class ProfileBasePage extends StatefulWidget {
  static String route = "/ProfileBasePage";
  const ProfileBasePage({super.key});

  @override
  State<ProfileBasePage> createState() => _ProfileBasePageState();
}

class _ProfileBasePageState extends State<ProfileBasePage> {
  List<TitleSubtitleModel> profileServices = [
    TitleSubtitleModel(
        title: R.appImages.emergencyIcon, subTitle: "emergency_contacts"),
    TitleSubtitleModel(
        title: R.appImages.biometricIcon, subTitle: "biometric_setup"),
    TitleSubtitleModel(
        title: R.appImages.batteryIcon, subTitle: "battery_management")
  ];

  List<TitleSubtitleModel> moreOptionsList = [
    TitleSubtitleModel(
        title: R.appImages.alertReferences,
        subTitle: "notification_alerts_preference"),
    TitleSubtitleModel(
        title: R.appImages.customizationIcon, subTitle: "theme_customization"),
    TitleSubtitleModel(title: R.appImages.tutorialIcon, subTitle: "tutorial"),
    TitleSubtitleModel(title: R.appImages.settingIcon, subTitle: "settings"),
  ];

  final GlobalKey globalKey1 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BasePagesSectionProvider provider =
            Provider.of<BasePagesSectionProvider>(context, listen: false);

        if (Constants.isShowCaseProfile) {
          globalKeyList = [
            globalKey1,
          ];
          setState(() {});
          Future.delayed(const Duration(milliseconds: 100), () {
            ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
          });
        }
      },
    );
  }

  int currentShowCaseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, profileBasePage, child) {
        return ShowCaseWidget(
          builder: (showcaseContext) {
            profileBasePage.myContext = showcaseContext;
            return Scaffold(
              backgroundColor: profileBasePage.themeModel.themeColor,
              appBar: AppBar(
                backgroundColor: profileBasePage.themeModel.themeColor,
                surfaceTintColor: profileBasePage.themeModel.themeColor,
                centerTitle: true,
                title: Text(
                  "account".L(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyShowCaseWidget(
                        myContext: profileBasePage.myContext!,
                        globalKey: globalKey1,
                        showCasePages: ShowCasePages.profileSettings,
                        hideBackButton: true,
                        showArrowLeftSide: false,
                        currentGuideIndex: 11,
                        title: 'manage_profile',
                        targetBorderRadius: 10,
                        isDismiss: false,
                        onOkTap: () async {
                          ShowCaseWidget.of(showcaseContext).dismiss();
                          await HiveDb.setShowCase(
                              false, ShowCasePages.profileSettings);
                          setState(() {});
                          Get.toNamed(EmergencyContactBasePages.route);
                          ShowCaseWidget.of(profileBasePage.myContext!).next();
                        },
                        description:
                            'easily_manage_your_profile_details_with_just_a_click',
                        onBarrierTab: () async {
                          ShowCaseWidget.of(showcaseContext).dismiss();
                          await HiveDb.setShowCase(
                              false, ShowCasePages.profileSettings);
                          setState(() {});
                          Get.toNamed(EmergencyContactBasePages.route);
                          ShowCaseWidget.of(profileBasePage.myContext!).next();
                        },
                        widget: IgnorePointer(
                          ignoring: Constants.isShowCaseProfile,
                          child: Container(
                            decoration: R.decoration.generalDecoration(
                              radius: 10,
                              backgroundColor: R.appColors.cardBackGroundGrey,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              leading: Image.asset(
                                R.appImages.childSampleImage,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                "William James",
                                style: R.textStyles.poppins(
                                    color: profileBasePage.isDarkTheme
                                        ? R.appColors.white
                                        : R.appColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "josephbiden@gmail.com",
                                    style: R.textStyles.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: profileBasePage.isDarkTheme
                                            ? R.appColors.white
                                                .withOpacity(0.38)
                                            : R.appColors.black
                                                .withOpacity(0.38)),
                                  ),
                                  Text(
                                    "+1 (555) 123-4567",
                                    style: R.textStyles.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: profileBasePage.isDarkTheme
                                            ? R.appColors.white
                                                .withOpacity(0.38)
                                            : R.appColors.black
                                                .withOpacity(0.38)),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      GlobalWidgets.editProfileBottomSheet();
                                    },
                                    child: Text(
                                      "edit".L(),
                                      style: R.textStyles.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: profileBasePage.isDarkTheme
                                              ? R.appColors.white
                                              : R.appColors.black
                                                  .withOpacity(0.38)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          profileServices.length,
                          (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  blockNavigation(index: index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: R.decoration.generalDecoration(
                                      radius: 8,
                                      backgroundColor:
                                          R.appColors.cardBackGroundGrey),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        profileServices[index].title,
                                        scale: 4,
                                      ),
                                      Text(
                                        profileServices[index].subTitle.L(),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: R.textStyles.poppins(
                                          fontSize: 13.sp,
                                          color: profileBasePage.isDarkTheme
                                              ? R.appColors.white
                                              : R.appColors.textGreyColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "more_options".L(),
                        style: R.textStyles.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.black),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            onTap: () => lisTileNavigation(
                                index: index,
                                profilePageProvider: profileBasePage),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: R.appColors.cardBackGroundGrey,
                              child: Image.asset(
                                moreOptionsList[index].title,
                                height: 21,
                              ),
                            ),
                            title: Text(
                              moreOptionsList[index].subTitle.L(),
                              style: R.textStyles.poppins(
                                  color: R.appColors.textGreyColor,
                                  fontSize: 16.sp),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: R.appColors.iconsGreyColor,
                            ),
                          );
                        },
                        itemCount: moreOptionsList.length,
                      )),
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

  void lisTileNavigation(
      {required int index,
      required BasePagesSectionProvider profilePageProvider}) {
    switch (index) {
      case 0:
        Get.toNamed(PreferencesPage.route);
      case 1:
        Get.toNamed(CustomizeThemePage.route);
      case 2:
        {
          HiveDb.setAllShowCaseValue(true);
          setState(() {});
          profilePageProvider.currentPage = Constants.pagesList[0];
          profilePageProvider.selectedBaseIndex = 0;
          profilePageProvider.update();
        }
      case 3:
        Get.toNamed(SettingsBasePage.route);
    }
  }

  void blockNavigation({required int index}) {
    switch (index) {
      case 0:
        Get.toNamed(EmergencyContactBasePages.route);
      case 1:
        Get.toNamed(BioMetricSetUpPage.route);
      case 2:
        Get.toNamed(BatteryManagementBasePage.route);
    }
  }
}
