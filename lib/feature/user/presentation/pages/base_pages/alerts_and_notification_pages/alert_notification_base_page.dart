import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
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
import '../manage_pages/sub_categories/device_pages/device_base_body.dart';
import '../manage_pages/sub_categories/manage_children_pages/manage_children_base_page.dart';

class AlertNotificationBasePage extends StatefulWidget {
  static String route = "/AlertNotificationBasePage";
  const AlertNotificationBasePage({super.key});

  @override
  State<AlertNotificationBasePage> createState() =>
      _AlertNotificationBasePageState();
}

class _AlertNotificationBasePageState extends State<AlertNotificationBasePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  List<GlobalKey> globalKeyList = [];
  List<Widget> manageCateBodyList = [
    const DeviceBaseBody(),
    const ManageChildrenBasePage(),
  ];

  int currentShowCaseIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final alertProvider = context.read<BasePagesSectionProvider>();
    alertProvider.alertTabBarController = TabController(length: 2, vsync: this);
    alertProvider.alertTabBarController.addListener(() {
      alertProvider.update();
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BasePagesSectionProvider provider =
            Provider.of<BasePagesSectionProvider>(context, listen: false);

        if (Constants.isShowCaseAlert) {
          globalKeyList = [
            globalKey1,
            globalKey2,
          ];
          setState(() {});

          ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
        builder: (context, alertOptionProvider, child) {
      return ShowCaseWidget(
        builder: (showCaseContext) {
          alertOptionProvider.myContext = showCaseContext;
          return DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              backgroundColor: alertOptionProvider.themeModel.themeColor,
              appBar: AppBar(
                backgroundColor: alertOptionProvider.themeModel.themeColor,
                surfaceTintColor: alertOptionProvider.themeModel.themeColor,
                centerTitle: true,
                title: Text(
                  "alerts_and_notifications".L(),
                  style: R.textStyles.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: R.appColors.white),
                ),
              ),
              body: SafeArea(
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: R.decoration.topRadius(
                      radius: 30, backgroundColor: R.appColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MyShowCaseWidget(
                          showCasePages: ShowCasePages.alert,
                          myContext: alertOptionProvider.myContext!,
                          globalKey: globalKey1,
                          hideBackButton: true,
                          currentGuideIndex: 4,
                          title: 'alerts',
                          onBarrierTab: () async {
                            ShowCaseWidget.of(alertOptionProvider.myContext!)
                                .next();
                            alertOptionProvider.alertTabBarController.index = 1;
                            alertOptionProvider.update();
                          },
                          targetBorderRadius: 30,
                          isDismiss: false,
                          onOkTap: () async {
                            alertOptionProvider.alertTabBarController.index = 1;
                            alertOptionProvider.update();
                            ShowCaseWidget.of(alertOptionProvider.myContext!)
                                .next();
                          },
                          description:
                              'stay_updated_on_critical_alerts_with_a_single_tap',
                          widget: MyShowCaseWidget(
                            showCasePages: ShowCasePages.alert,
                            myContext: alertOptionProvider.myContext!,
                            globalKey: globalKey2,
                            onBackTap: () async {
                              alertOptionProvider.alertTabBarController.index =
                                  0;
                              alertOptionProvider.update();
                              ShowCaseWidget.of(alertOptionProvider.myContext!)
                                  .previous();
                            },
                            currentGuideIndex: 5,
                            title: 'notifications',
                            onBarrierTab: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length) - 1) {
                                ShowCaseWidget.of(
                                        alertOptionProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.alert);
                                setState(() {});
                              }

                              alertOptionProvider.currentPage =
                                  Constants.pagesList[4];
                              alertOptionProvider.selectedBaseIndex = 4;
                              alertOptionProvider.update();
                            },
                            targetBorderRadius: 30,
                            isDismiss: false,
                            onOkTap: () async {
                              if (currentShowCaseIndex ==
                                  (globalKeyList.length) - 1) {
                                ShowCaseWidget.of(
                                        alertOptionProvider.myContext!)
                                    .dismiss();
                                await HiveDb.setShowCase(
                                    false, ShowCasePages.alert);
                                setState(() {});
                              }

                              alertOptionProvider.currentPage =
                                  Constants.pagesList[4];
                              alertOptionProvider.selectedBaseIndex = 4;
                              alertOptionProvider.update();
                            },
                            showArrowLeftSide: false,
                            description:
                                'keep_an_eye_on_the_recent_notifications_with_just_a_click',
                            widget: Container(
                              height: 39,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              decoration: R.decoration.generalDecoration(
                                  radius: 30,
                                  backgroundColor: R.appColors.lightGreyColor),
                              child: IgnorePointer(
                                ignoring: Constants.isShowCaseAlert,
                                child: TabBar(
                                  controller:
                                      alertOptionProvider.alertTabBarController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  dividerColor: R.appColors.transparent,
                                  indicatorColor:
                                      alertOptionProvider.themeModel.themeColor,
                                  unselectedLabelColor:
                                      alertOptionProvider.isDarkTheme
                                          ? R.appColors.white.withOpacity(.38)
                                          : R.appColors.textGreyColor,
                                  indicator: R.decoration.generalDecoration(
                                      radius: 30,
                                      backgroundColor: alertOptionProvider
                                          .themeModel.themeColor),
                                  labelColor: R.appColors.white,
                                  labelStyle: R.textStyles.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                  ),
                                  tabs: [
                                    Tab(
                                      icon: Text(
                                        "alerts".L(),
                                      ),
                                    ),
                                    Tab(
                                      icon: Text(
                                        "notifications".L(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                          child: TabBarView(
                              controller:
                                  alertOptionProvider.alertTabBarController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                            alertNotifications(alertOptionProvider),
                            simpleNotifications(alertOptionProvider)
                          ])),
                    ],
                  ),
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

  Widget alertNotifications(BasePagesSectionProvider provider) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: provider.isDarkTheme
                      ? R.appColors.lightGreyColor.withOpacity(.2)
                      : R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                    fontSize: 15.sp,
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
                fontSize: 13.sp,
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
                scale: 3,
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
                      fontSize: 12.sp,
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

  Widget simpleNotifications(BasePagesSectionProvider provider) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: provider.isDarkTheme
                      ? R.appColors.lightGreyColor.withOpacity(.2)
                      : R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                    fontSize: 15.sp,
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
                fontSize: 13.sp,
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
                      fontSize: 12.sp,
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
