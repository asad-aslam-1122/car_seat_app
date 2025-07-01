import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/title_subtitle_model.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/login_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/onboard_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../resources/resources.dart';
import '../../../../global/constant/enums.dart';
import '../../../../global/widget/change_language_widget.dart';

class OnboardPage extends StatefulWidget {
  static String route = "/OnboardPage";
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final PageController pageController = PageController();
  List<String> languagesList = ["english", "spanish"];
  List<TitleSubtitleModel> onBoardModelList = [
    TitleSubtitleModel(
        title: "welcome_to_car_seat_companion",
        subTitle:
            "monitor_your_childs_safety_in_real_time_with_alerts_for_temperature_pressure_and_location"),
    TitleSubtitleModel(
        title: "stay_notified_stay_informed",
        subTitle:
            "get_immediate_alerts_for_temperature_changes_inactivity_and_emergencies_with_escalation_to_emergency_contacts"),
    TitleSubtitleModel(
        title: "quick_setup_always_connected",
        subTitle:
            "pair_your_device_easily_and_stay_connected_with_Bluetooth_4G_5G_or_satellite_even_in_remote_areas")
  ];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OnBoardProvider, BasePagesSectionProvider>(
      builder: (context, onBoardProvider, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: themeColor.themeModel.themeColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      R.appImages.cscLogo,
                      scale: 4,
                    ),
                    const Spacer(),
                    const Spacer(),
                    containerChanger(
                        containerType: onBoardProvider.containerType,
                        basePagesSectionProvider: themeColor,
                        onboardProvider: onBoardProvider),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pageChangerContainer(
      {required OnBoardProvider onboardProvider,
      required BasePagesSectionProvider basePagesSectionProvider}) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(12),
      decoration: R.decoration
          .generalDecoration(radius: 20, backgroundColor: R.appColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
          ),
          SmoothPageIndicator(
              controller: pageController,
              count: onBoardModelList.length,
              effect: ExpandingDotsEffect(
                  activeDotColor:
                      basePagesSectionProvider.themeModel.themeColor,
                  dotHeight: 5,
                  expansionFactor: 1.5,
                  dotColor: R.appColors.deactivateColor),
              onDotClicked: (index) {}),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 22.h,
            child: PageView.builder(
              controller: pageController,
              itemCount: onBoardModelList.length,
              onPageChanged: (currentIndex) {
                onboardProvider.pageIndex = currentIndex;
                onboardProvider.update();
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      onBoardModelList[index].title.L(),
                      textAlign: TextAlign.center,
                      style: R.textStyles.poppins(
                          fontSize: 22.sp, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      onBoardModelList[index].subTitle.L(),
                      textAlign: TextAlign.center,
                      style: R.textStyles.poppins(
                          color: R.appColors.darkTextGreyColor,
                          fontSize: 15.sp),
                    ),
                  ],
                );
              },
            ),
          ),
          if (onboardProvider.pageIndex != onBoardModelList.length - 1)
            const SizedBox(
              height: 10,
            ),
          onboardProvider.pageIndex == onBoardModelList.length - 1
              ? CustomButton(
                  onPressed: () {
                    Get.offAllNamed(LoginPage.route);
                  },
                  title: "lets_get_started")
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        onPressed: () {
                          Get.offAndToNamed(LoginPage.route);
                        },
                        showTextButton: true,
                        height: 40,
                        width: 25.w,
                        radius: 8,
                        textColor: R.appColors.darkTextGreyColor,
                        textWeight: FontWeight.w500,
                        title: "skip"),
                    CustomButton(
                        onPressed: () => navigateToPage(),
                        height: 40,
                        width: 25.w,
                        radius: 8,
                        textWeight: FontWeight.w500,
                        title: "next"),
                  ],
                )
        ],
      ),
    );
  }

  Widget containerChanger(
      {required ContainerType containerType,
      required BasePagesSectionProvider basePagesSectionProvider,
      required OnBoardProvider onboardProvider}) {
    switch (containerType) {
      case ContainerType.languageContainer:
        {
          return ChangeLanguageWidget(
            onboardProvider: onboardProvider,
            onBtnPressed: () {
              onboardProvider.containerType =
                  ContainerType.pageChangerContainer;
              onboardProvider.update();
            },
          );
        }
      case ContainerType.pageChangerContainer:
        {
          return pageChangerContainer(
              onboardProvider: onboardProvider,
              basePagesSectionProvider: basePagesSectionProvider);
        }
      default:
        {
          return const SizedBox();
        }
    }
  }

  void navigateToPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
