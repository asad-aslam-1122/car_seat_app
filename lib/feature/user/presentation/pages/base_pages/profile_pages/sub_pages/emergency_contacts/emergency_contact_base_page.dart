import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/cards_widgets/contact_card.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/contact_model.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/add_emergency_contact_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/biometric_setup_page/bio_metric_set_up_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../../services/hive_services.dart';
import '../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../global/constant/enums.dart';
import '../../../../../../../global/widget/custom_button.dart';
import '../../../../core_pages/empty_case_page.dart';

class EmergencyContactBasePages extends StatefulWidget {
  static String route = "/EmergencyContactBasePages";
  const EmergencyContactBasePages({super.key});

  @override
  State<EmergencyContactBasePages> createState() =>
      _EmergencyContactBasePagesState();
}

class _EmergencyContactBasePagesState extends State<EmergencyContactBasePages> {
  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BasePagesSectionProvider provider =
          Provider.of<BasePagesSectionProvider>(context, listen: false);

      if (Constants.isShowCaseEmergency) {
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
      builder: (context, emergencyContactProvider, child) {
        return ShowCaseWidget(
          onStart: (index, wid) {
            if (index == (globalKeyList.length - 1)) {
              currentShowCaseIndex = int.parse("$index");
              setState(() {});
            }
          },
          builder: (showCaseContext) {
            emergencyContactProvider.myContext = showCaseContext;
            return SafeAreaWidget(
              child: Scaffold(
                backgroundColor: emergencyContactProvider.themeModel.themeColor,
                appBar: AppBar(
                  backgroundColor:
                      emergencyContactProvider.themeModel.themeColor,
                  surfaceTintColor:
                      emergencyContactProvider.themeModel.themeColor,
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
                    "emergency_contacts_".L(),
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
                        Text(
                          "manage_contacts".L(),
                          style: R.textStyles.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "add_up_to_three_contacts_to_receive_alerts_in_case_of_an_emergency"
                              .L(),
                          style: R.textStyles.poppins(
                              color: R.appColors.textGreyColor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (Constants.isShowCaseEmergency)
                          MyShowCaseWidget(
                            showCasePages: ShowCasePages.emergency,
                            myContext: emergencyContactProvider.myContext!,
                            globalKey: globalKey1,
                            hideBackButton: true,
                            showArrowLeftSide: false,
                            currentGuideIndex: 12,
                            title: 'emergency_contacts_',
                            targetBorderRadius: 10,
                            isDismiss: false,
                            onOkTap: () async {
                              emergencyContactProvider
                                  .alertTabBarController.index = 1;
                              emergencyContactProvider.update();
                              ShowCaseWidget.of(showCaseContext).next();
                            },
                            description:
                                'manage_your_emergency_contacts_and_assign_them_a_priority_level',
                            widget: IgnorePointer(
                              ignoring: Constants.isShowCaseSOS,
                              child: ContactCard(
                                  contactModel: Constants.dummyContactModel,
                                  index: 2,
                                  showPhoneIcon: false,
                                  onEditItemTab: () {},
                                  onRemoveItemTab: () {}),
                            ),
                          ),
                        if (!Constants.isShowCaseEmergency)
                          emergencyContactProvider.emergencyContactList.isEmpty
                              ? EmptyCasePage(
                                  title: "no_contacts_found".L(),
                                  subTitle:
                                      "add_a_contact_now_to_receive_alerts".L(),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    itemBuilder: (context, index) {
                                      ContactModel contactModel =
                                          emergencyContactProvider
                                              .emergencyContactList[index];
                                      return ContactCard(
                                          contactModel: contactModel,
                                          index: 2,
                                          showPhoneIcon: false,
                                          onEditItemTab: () {},
                                          onRemoveItemTab: () {});
                                    },
                                    itemCount: emergencyContactProvider
                                        .emergencyContactList.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  color: R.appColors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: MyShowCaseWidget(
                    showCasePages: ShowCasePages.emergency,
                    myContext: emergencyContactProvider.myContext!,
                    globalKey: globalKey2,
                    onBackTap: () {
                      ShowCaseWidget.of(showCaseContext).previous();
                    },
                    tooltipPosition: TooltipPosition.top,
                    currentGuideIndex: 13,
                    title: 'add_emergency_contact',
                    targetBorderRadius: 10,
                    isDismiss: false,
                    onOkTap: () async {
                      if (currentShowCaseIndex == (globalKeyList.length - 1)) {
                        ShowCaseWidget.of(emergencyContactProvider.myContext!)
                            .dismiss();
                        await HiveDb.setShowCase(
                            false, ShowCasePages.emergency);
                        setState(() {});
                      }

                      Get.offAndToNamed(BioMetricSetUpPage.route);
                    },
                    onBarrierTab: () async {
                      if (currentShowCaseIndex == (globalKeyList.length - 1)) {
                        ShowCaseWidget.of(showCaseContext).dismiss();
                        await HiveDb.setShowCase(
                            false, ShowCasePages.emergency);
                        setState(() {});
                      }
                      Get.offAndToNamed(BioMetricSetUpPage.route);
                    },
                    description:
                        'add_up_to_3_emergency_contacts_for_immediate_help',
                    widget: IgnorePointer(
                      ignoring: Constants.isShowCaseEmergency,
                      child: CustomButton(
                          onPressed: () {
                            if (emergencyContactProvider
                                    .emergencyContactList.length ==
                                3) {
                              ZBotToast.showToastError(
                                  message: "you_cant_add_more_than_3_contacts");
                            } else {
                              Get.toNamed(AddEmergencyContactPage.route,
                                  arguments: {
                                    "appBarTitle": "add_contact",
                                    "isEditAble": false,
                                    "isFromSignUp": false,
                                    "index": 0
                                  });
                            }
                          },
                          title: "add_new_contact"),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
