import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/qr_code_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/device_base_body.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/manage_children_pages/manage_children_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/manage_children_pages/sub_pages/add_child_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/vehicales_pages/manage_vehicle_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/vehicales_pages/sub_pages/add_vehicle_page.dart';
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
import 'sub_categories/device_pages/bluetooth_pages/bluetooth_base_page.dart';

class ManageBasePages extends StatefulWidget {
  static String route = "/ManageBasePages";
  const ManageBasePages({super.key});

  @override
  State<ManageBasePages> createState() => _ManageBasePagesState();
}

class _ManageBasePagesState extends State<ManageBasePages>
    with SingleTickerProviderStateMixin {
  List<String> manageCateList = ["devices", "children", "vehicles"];
  List<Widget> manageCateBodyList = [
    const DeviceBaseBody(),
    const ManageChildrenBasePage(),
    const ManageVehicleBasePage(),
  ];

  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  final GlobalKey globalKey3 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    super.initState();
    final managePageProvider = context.read<BasePagesSectionProvider>();
    managePageProvider.tabController =
        TabController(length: manageCateList.length, vsync: this);
    managePageProvider.tabController.addListener(() {
      managePageProvider.update();
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BasePagesSectionProvider provider =
            Provider.of<BasePagesSectionProvider>(context, listen: false);

        if (Constants.isShowCaseManage) {
          globalKeyList = [
            globalKey1,
            globalKey2,
            globalKey3,
          ];

          setState(() {});

          ShowCaseWidget.of(provider.myContext!).startShowCase(globalKeyList);
        }
      },
    );
  }

  int currentShowCaseIndex = 0;

  List<Map<String, dynamic>> popUpMenu = [
    {
      "image": R.appImages.blueToothIcon,
      "title": "via_bluetooth",
    },
    {
      "image": R.appImages.qrScannerIcon,
      "title": "via_qr_code",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, managePageProvider, child) {
        return ShowCaseWidget(
          builder: (showCaseContext) {
            managePageProvider.myContext = showCaseContext;
            return DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Scaffold(
                    backgroundColor: managePageProvider.themeModel.themeColor,
                    appBar: AppBar(
                      backgroundColor: managePageProvider.themeModel.themeColor,
                      surfaceTintColor:
                          managePageProvider.themeModel.themeColor,
                      centerTitle: true,
                      title: Text(
                        "manage".L(),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: MyShowCaseWidget(
                                showCasePages: ShowCasePages.manage,
                                globalKey: globalKey1,
                                hideBackButton: true,
                                currentGuideIndex: 8,
                                targetBorderRadius: 30,
                                myContext: showCaseContext,
                                title: "manage_devices",
                                onOkTap: () async {
                                  managePageProvider.tabController.index = 1;
                                  managePageProvider.update();
                                  ShowCaseWidget.of(showCaseContext).next();
                                },
                                onBarrierTab: () async {
                                  managePageProvider.tabController.index = 1;
                                  managePageProvider.update();
                                  ShowCaseWidget.of(showCaseContext).next();
                                },
                                description:
                                    "add_and_manage_devices_for_real_time_monitoring_and_updates",
                                widget: MyShowCaseWidget(
                                  showCasePages: ShowCasePages.manage,
                                  globalKey: globalKey2,
                                  currentGuideIndex: 9,
                                  targetBorderRadius: 30,
                                  myContext: showCaseContext,
                                  showIndicatorInCenter: true,
                                  title: "manage_children",
                                  onOkTap: () async {
                                    managePageProvider.tabController.index = 2;
                                    managePageProvider.update();
                                    ShowCaseWidget.of(showCaseContext).next();
                                  },
                                  onBarrierTab: () async {
                                    managePageProvider.tabController.index = 2;
                                    managePageProvider.update();
                                    ShowCaseWidget.of(showCaseContext).next();
                                  },
                                  onBackTap: () {
                                    managePageProvider.tabController.index = 0;
                                    managePageProvider.update();
                                    ShowCaseWidget.of(showCaseContext)
                                        .previous();
                                  },
                                  description:
                                      "add_and_manage_children_for_real_time_monitoring_and_updates",
                                  widget: MyShowCaseWidget(
                                    showCasePages: ShowCasePages.manage,
                                    globalKey: globalKey3,
                                    currentGuideIndex: 10,
                                    targetBorderRadius: 30,
                                    myContext: showCaseContext,
                                    showArrowLeftSide: false,
                                    title: "manage_vehicles",
                                    onOkTap: () async {
                                      if (currentShowCaseIndex ==
                                          (globalKeyList.length - 1)) {
                                        ShowCaseWidget.of(
                                                managePageProvider.myContext!)
                                            .dismiss();
                                        await HiveDb.setShowCase(
                                            false, ShowCasePages.manage);
                                        setState(() {});
                                      }
                                      managePageProvider.currentPage =
                                          Constants.pagesList[3];
                                      managePageProvider.selectedBaseIndex = 3;
                                      ShowCaseWidget.of(
                                              managePageProvider.myContext!)
                                          .next();
                                      managePageProvider.update();
                                    },
                                    onBarrierTab: () async {
                                      if (currentShowCaseIndex ==
                                          (globalKeyList.length - 1)) {
                                        ShowCaseWidget.of(
                                                managePageProvider.myContext!)
                                            .dismiss();
                                        await HiveDb.setShowCase(
                                            false, ShowCasePages.manage);
                                        setState(() {});
                                      }
                                      managePageProvider.currentPage =
                                          Constants.pagesList[3];
                                      managePageProvider.selectedBaseIndex = 3;
                                      ShowCaseWidget.of(
                                              managePageProvider.myContext!)
                                          .next();
                                      managePageProvider.update();
                                    },
                                    onBackTap: () {
                                      managePageProvider.tabController.index =
                                          1;
                                      managePageProvider.update();
                                      ShowCaseWidget.of(showCaseContext)
                                          .previous();
                                    },
                                    description:
                                        "add_and_manage_vehicles_for_real_time_monitoring_and_updates",
                                    widget: Container(
                                      height: 39,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      decoration: R.decoration
                                          .generalDecoration(
                                              radius: 30,
                                              backgroundColor:
                                                  R.appColors.lightGreyColor),
                                      child: IgnorePointer(
                                        ignoring: Constants.isShowCaseManage,
                                        child: TabBar(
                                          controller:
                                              managePageProvider.tabController,
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          dividerColor: R.appColors.transparent,
                                          indicatorColor: managePageProvider
                                              .themeModel.themeColor,
                                          unselectedLabelColor:
                                              managePageProvider.isDarkTheme
                                                  ? R.appColors.white
                                                      .withOpacity(.38)
                                                  : R.appColors.textGreyColor,
                                          indicator: R.decoration
                                              .generalDecoration(
                                                  radius: 30,
                                                  backgroundColor:
                                                      managePageProvider
                                                          .themeModel
                                                          .themeColor),
                                          labelColor: R.appColors.white,
                                          labelStyle: R.textStyles.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                          ),
                                          tabs: [
                                            Tab(
                                              icon: Text(
                                                "devices".L(),
                                              ),
                                            ),
                                            Tab(
                                              icon: Text(
                                                "children".L(),
                                              ),
                                            ),
                                            Tab(
                                              icon: Text(
                                                "vehicles".L(),
                                              ),
                                            )
                                          ],
                                        ),
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
                                        managePageProvider.tabController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: manageCateBodyList)),
                          ],
                        ),
                      ),
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: floatingActionBtn(
                        managePageProvider: managePageProvider)));
          },
          onStart: (index, wid) {
            if (index == (globalKeyList.length - 1)) {
              currentShowCaseIndex = int.parse("$index");
              setState(() {});
            }
          },
        );
      },
    );
  }

  Widget floatingActionBtn({required final managePageProvider}) {
    if (managePageProvider.tabController.index == 0) {
      return Stack(
        children: [
          if (managePageProvider.isPopUpOpened)
            Positioned.fill(
              child: Container(
                color: R.appColors.black.withOpacity(0.28),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: PopupMenuButton(
              shadowColor: R.appColors.white,
              elevation: 0,
              color: R.appColors.transparent,
              offset: const Offset(60, -140),
              onCanceled: () {
                managePageProvider.isPopUpOpened = false;
                managePageProvider.update();
              },
              onOpened: () {
                managePageProvider.isPopUpOpened = true;
                managePageProvider.update();
              },
              padding: const EdgeInsets.all(0),
              itemBuilder: (BuildContext context) {
                return List.generate(2, (index) {
                  return PopupMenuItem(
                    padding: const EdgeInsets.all(4),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.toNamed(BluetoothBasePage.route);
                          break;

                        case 1:
                          Get.to(() => const QrCodePage());
                          break;
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 16),
                          decoration: R.decoration.generalShadowDecoration(
                              radius: 6, backgroundColor: R.appColors.white),
                          child: Text(
                            popUpMenu[index]["title"].toString().L(),
                            style: R.textStyles.poppins(
                                color: R.appColors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          height: 56,
                          width: 56,
                          decoration: R.decoration.circleShapeWithShadow(
                              backgroundColor: R.appColors.white,
                              shadowColor: R.appColors.black.withOpacity(0.2)),
                          child: Image.asset(popUpMenu[index]["image"],
                              scale: 4,
                              color: managePageProvider.themeModel.themeColor),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Container(
                height: 56,
                width: 56,
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: managePageProvider.themeModel.themeColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    managePageProvider.isPopUpOpened ? Icons.close : Icons.add,
                    color: R.appColors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Align(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            if (managePageProvider.tabController.index == 1) {
              Get.toNamed(AddChildPage.route,
                  arguments: {"isEditAble": false, "index": 0});
            } else {
              Get.toNamed(AddVehiclePage.route,
                  arguments: {"isEditAble": false, "index": 0});
            }
          },
          child: Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: managePageProvider.themeModel.themeColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                managePageProvider.isPopUpOpened ? Icons.close : Icons.add,
                color: R.appColors.white,
                size: 35,
              ),
            ),
          ),
        ),
      );
    }
  }
}
