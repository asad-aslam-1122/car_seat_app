import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/cards_widgets/contact_card.dart';
import 'package:car_seat/feature/user/data/model/contact_model.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/alerts_and_notification_pages/detailed_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../services/hive_services.dart';
import '../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../global/constant/constants.dart';
import '../../../../../global/constant/enums.dart';
import '../../../../../global/widget/global_widgets/global_widgets.dart';
import '../../auth_pages/add_emergency_contact_page.dart';
import '../../core_pages/empty_case_page.dart';

class SosDashboardBasePage extends StatefulWidget {
  static String route = "/SosDashboardBasePage";
  const SosDashboardBasePage({super.key});

  @override
  State<SosDashboardBasePage> createState() => _SosDashboardBasePageState();
}

class _SosDashboardBasePageState extends State<SosDashboardBasePage> {
  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  ContactModel serviceContactModel =
      ContactModel(name: "911", mobileNumber: "", relation: "", purity: "");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BasePagesSectionProvider provider =
            Provider.of<BasePagesSectionProvider>(context, listen: false);

        if (Constants.isShowCaseSOS) {
          globalKeyList = [
            globalKey1,
            globalKey2,
          ];

          setState(() {});

          ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
        }
      },
    );
    super.initState();
  }

  int currentShowCaseIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
        builder: (context, themeProvider, child) {
      return ShowCaseWidget(
        builder: (showCaseContext) {
          themeProvider.myContext = showCaseContext;
          return Scaffold(
            backgroundColor: themeProvider.themeModel.themeColor,
            appBar: AppBar(
              backgroundColor: themeProvider.themeModel.themeColor,
              surfaceTintColor: themeProvider.themeModel.themeColor,
              centerTitle: true,
              title: Text(
                "sos".L(),
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
                decoration: R.decoration
                    .topRadius(radius: 30, backgroundColor: R.appColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "emergency_sos".L(),
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w600, fontSize: 18.sp),
                    ),
                    Text(
                      "press_the_call_button_below_for_immediate_assistance"
                          .L(),
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w500,
                          color: R.appColors.textGreyColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "services_".L(),
                      style: R.textStyles.poppins(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyShowCaseWidget(
                      showCasePages: ShowCasePages.sos,
                      globalKey: globalKey1,
                      hideBackButton: true,
                      currentGuideIndex: 6,
                      targetBorderRadius: 10,
                      myContext: showCaseContext,
                      title: "immediate_assistance",
                      onOkTap: () {
                        ShowCaseWidget.of(showCaseContext).next();
                      },
                      description:
                          "automatically_calls_911_for_immediate_assistance_in_critical_situations",
                      widget: IgnorePointer(
                        ignoring: Constants.isShowCaseSOS,
                        child: ContactCard(
                            contactModel: serviceContactModel,
                            index: -1,
                            canEdit: false,
                            showPhoneIcon: true,
                            showPurity: false,
                            onEditItemTab: () {},
                            onRemoveItemTab: () {}),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (themeProvider.emergencyContactList.isNotEmpty ||
                        Constants.isShowCaseSOS)
                      Text(
                        "${"emergency_contacts_".L()}:",
                        style:
                            R.textStyles.poppins(fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (Constants.isShowCaseSOS)
                      MyShowCaseWidget(
                        globalKey: globalKey2,
                        showCasePages: ShowCasePages.sos,
                        onBackTap: () {
                          ShowCaseWidget.of(showCaseContext).previous();
                        },
                        onBarrierTab: () async {
                          if (currentShowCaseIndex ==
                              (globalKeyList.length - 1)) {
                            ShowCaseWidget.of(themeProvider.myContext!)
                                .dismiss();
                            await HiveDb.setShowCase(false, ShowCasePages.sos);
                            setState(() {});
                          }
                          themeProvider.currentPage = Constants.pagesList[2];
                          themeProvider.selectedBaseIndex = 2;
                          themeProvider.update();
                        },
                        currentGuideIndex: 7,
                        targetBorderRadius: 10,
                        myContext: showCaseContext,
                        title: "emergency_contacts_",
                        onOkTap: () async {
                          if (currentShowCaseIndex ==
                              (globalKeyList.length - 1)) {
                            ShowCaseWidget.of(themeProvider.myContext!)
                                .dismiss();
                            await HiveDb.setShowCase(false, ShowCasePages.sos);
                            setState(() {});
                          }

                          themeProvider.currentPage = Constants.pagesList[2];
                          themeProvider.selectedBaseIndex = 2;
                          themeProvider.update();
                        },
                        description:
                            "quickly_manage_and_call_your_emergency_contacts_for_quick_response",
                        widget: IgnorePointer(
                          ignoring: Constants.isShowCaseSOS,
                          child: ContactCard(
                              contactModel: Constants.dummyContactModel,
                              index: 1,
                              showPhoneIcon: true,
                              onEditItemTab: () {},
                              onRemoveItemTab: () {}),
                        ),
                      ),
                    if (!Constants.isShowCaseSOS)
                      themeProvider.emergencyContactList.isEmpty
                          ? EmptyCasePage(
                              title: "no_contacts_found".L(),
                              subTitle:
                                  "add_a_contact_now_to_receive_alerts".L(),
                            )
                          : Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  ContactModel contactModel =
                                      themeProvider.emergencyContactList[index];
                                  return ContactCard(
                                      contactModel: contactModel,
                                      index: index,
                                      showPhoneIcon: true,
                                      onEditItemTab: () {
                                        Get.toNamed(
                                            AddEmergencyContactPage.route,
                                            arguments: {
                                              "appBarTitle": "edit_contact",
                                              "isEditAble": true,
                                              "isFromSignUp": false,
                                              "index": index,
                                              "contactModel": contactModel,
                                            });
                                      },
                                      onRemoveItemTab: () {
                                        GlobalWidgets.titleWithBtnBottomSheet(
                                          title:
                                              "are_you_sure_you_want_to_remove_this_emergency_contact",
                                          onRightBtnPressed: () {
                                            themeProvider.emergencyContactList
                                                .removeAt(index);
                                            setState(() {});

                                            ZBotToast.showCustomToast(
                                                context,
                                                'contact_removed',
                                                "contact_has_been_removed_successfully");

                                            Get.back();
                                          },
                                        );
                                      });
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount:
                                    themeProvider.emergencyContactList.length,
                              ),
                            )
                  ],
                ),
              ),
            ),
          );
        },
        onStart: (index, wid) {
          if (index == (globalKeyList.length - 1)) {
            currentShowCaseIndex = int.parse("$index");
            setState(() {});
          }
        },
      );
    });
  }

  Widget alertNotifications() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {
              Get.toNamed(AlertDetailedPage.route,
                  arguments: {"indexValue": index});
            },
            title: Row(
              children: [
                if (index == 0)
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: R.appColors.greenColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  index == 1
                      ? "Temporature Alert"
                      : index == 2
                          ? "InActivity Alert"
                          : "Pressure Alert",
                  style: R.textStyles.poppins(
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                    color: R.appColors.black,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              index == 1
                  ? "A temperature alert is shared with your secondary emergency contacts. Click to view the amber alert."
                  : index == 2
                      ? "An inactivity alert call is triggered to 911 for safety of your child."
                      : "A pressure alert is shared with your secondary emergency contacts. Click to view the amber alert",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                fontSize: 12.sp,
                color: R.appColors.black.withOpacity(0.38),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: R.appColors.lightGreyColor,
              child: Image.asset(
                index == 1
                    ? R.appImages.temporatureIcon
                    : index == 2
                        ? R.appImages.inActivityIcon
                        : R.appImages.pressureIcon,
                scale: 4,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    index == 0 ? "now".L() : "2 mins ago",
                    style: R.textStyles.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: R.appColors.textGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0, // Remove default vertical spacing
          thickness: 1, // Set thickness as per design
          color: R.appColors.black.withOpacity(0.1),
        );
      },
    );
  }

  Widget simpleNotifications() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {},
            title: Row(
              children: [
                if (index == 0)
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: R.appColors.greenColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Child Not Detected",
                  style: R.textStyles.poppins(
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                    color: R.appColors.black,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "Attention! Your child is no longer detected in the car seat. Please check their status immediately.",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                fontSize: 12.sp,
                color: R.appColors.black.withOpacity(0.38),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: R.appColors.lightGreyColor,
              child: Image.asset(
                R.appImages.childIcon,
                scale: 4,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    index == 0 ? "now".L() : "2 mins ago",
                    style: R.textStyles.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: R.appColors.textGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0, // Remove default vertical spacing
          thickness: 1, // Set thickness as per design
          color: R.appColors.black.withOpacity(0.1),
        );
      },
    );
  }
}
