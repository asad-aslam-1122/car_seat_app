import 'package:car_seat/feature/global/bot_toast/zbot_toast.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/login_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/settings/sub_pages/update_password_page.dart';
import 'package:car_seat/feature/user/presentation/pages/terms_and_privacy_pages/terms_and_conditions.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/onboard_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../global/widget/change_language_widget.dart';
import '../../../../../../data/model/title_subtitle_model.dart';

class SettingsBasePage extends StatelessWidget {
  static String route = "/SettingsBasePage";
  SettingsBasePage({super.key});
  List<String> languagesList = ["english", "spanish"];
  List<TitleSubtitleModel> moreOptionsList = [
    TitleSubtitleModel(
        title: R.appImages.lockIcon, subTitle: "change_password"),
    TitleSubtitleModel(
        title: R.appImages.changeLanguageIcon, subTitle: "change_language"),
    TitleSubtitleModel(title: R.appImages.termsIcon, subTitle: "terms_of_use"),
    TitleSubtitleModel(
        title: R.appImages.privacyIcon, subTitle: "privacy_policy"),
    TitleSubtitleModel(title: R.appImages.logoutIcon, subTitle: "log_out")
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeColor, child) {
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
                "settings".L(),
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
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () =>
                            lisTileNavigation(index: index, context: context),
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
            ),
          ),
        );
      },
    );
  }

  void lisTileNavigation({required int index, required BuildContext context}) {
    switch (index) {
      case 0:
        Get.toNamed(UpdatePasswordPage.route);
      case 1:
        showDialog(
          context: context,
          builder: (context) {
            return ChangeLanguageWidget(
                onboardProvider: context.read<OnBoardProvider>(),
                giveMargin: true,
                onBtnPressed: () {
                  ZBotToast.showCustomToast(context, "language_changed",
                      "language_has_been_changed_successfully");
                  Get.back();
                });
          },
        );
      case 2:
        Get.toNamed(TermsAndConditions.route,
            arguments: {"pageTitle": "terms_of_use"});
      case 3:
        Get.toNamed(TermsAndConditions.route,
            arguments: {"pageTitle": "privacy_policy"});
      case 4:
        GlobalWidgets.titleWithBtnBottomSheet(
            onRightBtnPressed: () {
              Get.offAllNamed(LoginPage.route);
            },
            height: 20.h,
            title: "are_you_sure_you_want_to_log_out_");
    }
  }
}
