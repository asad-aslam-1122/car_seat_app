import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/custom_switch_button.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/battory_management_section/battery_management_base_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../services/hive_services.dart';
import '../../../../../../../global/constant/constants.dart';
import '../../../../../../../global/constant/enums.dart';
import '../../../../../../../global/widget/biometric_password_enable_bottom_sheet.dart';

class BioMetricSetUpPage extends StatefulWidget {
  static String route = "/BioMetricSetUpPage";
  const BioMetricSetUpPage({super.key});

  @override
  State<BioMetricSetUpPage> createState() => _BioMetricSetUpPageState();
}

class _BioMetricSetUpPageState extends State<BioMetricSetUpPage> {
  final GlobalKey globalKey1 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BasePagesSectionProvider provider =
          Provider.of<BasePagesSectionProvider>(context, listen: false);

      if (Constants.isShowCaseBiometric) {
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
      builder: (context, bioMetricLoginProvider, child) {
        return ShowCaseWidget(
          onStart: (index, wid) {
            if (index == (globalKeyList.length - 1)) {
              currentShowCaseIndex = int.parse("$index");
              setState(() {});
            }
          },
          builder: (showCaseContext) {
            bioMetricLoginProvider.myContext = showCaseContext;
            return SafeAreaWidget(
              child: Scaffold(
                backgroundColor: bioMetricLoginProvider.themeModel.themeColor,
                appBar: AppBar(
                  backgroundColor: bioMetricLoginProvider.themeModel.themeColor,
                  surfaceTintColor:
                      bioMetricLoginProvider.themeModel.themeColor,
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
                    "biometric_setup_".L(),
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
                            myContext: bioMetricLoginProvider.myContext!,
                            showCasePages: ShowCasePages.biometric,
                            globalKey: globalKey1,
                            hideBackButton: true,
                            showArrowLeftSide: false,
                            currentGuideIndex: 14,
                            title: 'biometrics_login',
                            targetBorderRadius: 10,
                            isDismiss: false,
                            onOkTap: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length - 1)) {
                                ShowCaseWidget.of(
                                        bioMetricLoginProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.biometric);
                                setState(() {});
                              }
                              Get.offAndToNamed(
                                  BatteryManagementBasePage.route);
                              ShowCaseWidget.of(
                                      bioMetricLoginProvider.myContext!)
                                  .next();
                            },
                            onBarrierTab: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length - 1)) {
                                ShowCaseWidget.of(
                                        bioMetricLoginProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.biometric);
                                setState(() {});
                              }
                              Get.offAndToNamed(
                                  BatteryManagementBasePage.route);
                              ShowCaseWidget.of(
                                      bioMetricLoginProvider.myContext!)
                                  .next();
                            },
                            description:
                                'manage_your_emergency_contacts_and_assign_them_a_priority_level',
                            widget: IgnorePointer(
                              ignoring: Constants.isShowCaseBiometric,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 8),
                                title: Text(
                                  "biometric_login".L(),
                                  style: R.textStyles.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                                subtitle: Text(
                                  "enable_biometric_login_to_securely_access_the_app"
                                      .L(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: R.textStyles.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: R.appColors.textGreyColor),
                                ),
                                trailing: CustomSwitch(
                                    value:
                                        bioMetricLoginProvider.bioMetricLogin,
                                    onChanged: (newValue) {
                                      Get.bottomSheet(
                                          const BiometricPasswordEnableBottomSheet());
                                    },
                                    color: bioMetricLoginProvider
                                        .themeModel.themeColor),
                              ),
                            ),
                          ),
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
