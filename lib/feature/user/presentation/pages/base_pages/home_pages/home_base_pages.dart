import 'dart:async';
import 'dart:developer';

import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/showcase_widget/my_show_case_widget.dart';
import 'package:car_seat/feature/global/widget/temperature_widget.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../../services/hive_services.dart';
import '../../../../../global/constant/enums.dart';
import '../../../../../global/widget/custom_switch_button.dart';

class HomeBasePages extends StatefulWidget {
  static String route = "/HomeBasePages";
  const HomeBasePages({super.key});

  @override
  State<HomeBasePages> createState() => _HomeBasePagesState();
}

class _HomeBasePagesState extends State<HomeBasePages> {
  late Timer _timer;
  double temperatureValue = 100;
  bool childAvailability = false;
  String userName = "John Doe";
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final marker = <Marker>{};
  late final CameraPosition cameraPosition;

  int currentShowCaseIndex = 0;

  changeTemperature() {
    const oneSec = Duration(milliseconds: 200);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (temperatureValue == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          temperatureValue--;
          setState(() {});
        }
      },
    );
  }

  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  final GlobalKey globalKey3 = GlobalKey();
  List<GlobalKey> globalKeyList = [];

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: Constants.currentLatLng,
      zoom: 14,
    );
    marker.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: Constants.currentLatLng));

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        log("CURRENT ${Get.currentRoute}");
        if (Constants.isShowCaseHome) {
          globalKeyList = [
            globalKey1,
            globalKey2,
            globalKey3,
          ];
          setState(() {});
          ShowCaseWidget.of(context.read<BasePagesSectionProvider>().myContext!)
              .startShowCase(globalKeyList);

          setState(() {});
        } else {
          changeTemperature();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
        builder: (context, homeProvider, child) {
      return ShowCaseWidget(
        builder: (BuildContext showCaseContext) {
          homeProvider.myContext = showCaseContext;
          return Scaffold(
            backgroundColor: R.appColors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${"welcome".L()}, $userName!",
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w500, fontSize: 15.sp),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "child_availability_".L(),
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15.sp),
                      ),
                    ),
                    MyShowCaseWidget(
                      showCasePages: ShowCasePages.home,
                      myContext: homeProvider.myContext!,
                      globalKey: globalKey1,
                      hideBackButton: true,
                      currentGuideIndex: 1,
                      title: 'child_status',
                      targetBorderRadius: 10,
                      isDismiss: false,
                      onOkTap: () async {
                        ShowCaseWidget.of(homeProvider.myContext!).next();
                      },
                      description:
                          'view_your_child_status_directly_from_your_home_screen',
                      widget: childAvailableBox(
                          batteryPowerValue: 70,
                          childAvailability:
                              (temperatureValue > 30 && temperatureValue <= 80)
                                  ? true
                                  : false,
                          childName: "Diana",
                          childAge: 2,
                          deviceConnectionState:
                              DeviceConnectionState.blueTooth,
                          childProfileImage: R.appImages.childSampleImage),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "car_temperature_".L(),
                          style: R.textStyles.poppins(
                              fontWeight: FontWeight.w600, fontSize: 15.sp),
                        ),
                        CustomSwitch(
                            value: homeProvider.isTempShowSwitchActive,
                            onChanged: (updatedValue) {
                              homeProvider.isTempShowSwitchActive =
                                  updatedValue;
                              homeProvider.update();
                            },
                            color: homeProvider.themeModel.themeColor)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (homeProvider.isTempShowSwitchActive)
                      MyShowCaseWidget(
                          showCasePages: ShowCasePages.home,
                          myContext: homeProvider.myContext!,
                          globalKey: globalKey2,
                          onBackTap: () {
                            // homeProvider.currentGuideIndex =
                            //     homeProvider.currentGuideIndex - 1;
                            // homeProvider.update();
                            ShowCaseWidget.of(homeProvider.myContext!)
                                .previous();
                          },
                          currentGuideIndex: 2,
                          title: 'car_temperature',
                          targetBorderRadius: 10,
                          isDismiss: false,
                          onOkTap: () async {
                            ShowCaseWidget.of(homeProvider.myContext!).next();
                          },
                          description:
                              'view_your_cars_temperature_directly_from_your_home_screen',
                          widget: carTempDetailBox()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "car_location_".L(),
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w600, fontSize: 15.sp),
                      ),
                    ),
                    MyShowCaseWidget(
                        showCasePages: ShowCasePages.home,
                        myContext: homeProvider.myContext!,
                        currentGuideIndex: 3,
                        globalKey: globalKey3,
                        onBackTap: () {
                          ShowCaseWidget.of(showCaseContext).previous();
                        },
                        onBarrierTab: () async {
                          if (currentShowCaseIndex ==
                              (globalKeyList.length) - 1) {
                            ShowCaseWidget.of(homeProvider.myContext!)
                                .dismiss();
                            await HiveDb.setShowCase(false, ShowCasePages.home);
                            setState(() {});
                          }

                          homeProvider.currentPage = Constants.pagesList[1];
                          homeProvider.selectedBaseIndex = 1;
                          homeProvider.update();
                        },
                        title: 'car_location',
                        tooltipPosition: TooltipPosition.top,
                        targetBorderRadius: 10,
                        isDismiss: false,
                        onOkTap: () async {
                          if (currentShowCaseIndex ==
                              (globalKeyList.length) - 1) {
                            ShowCaseWidget.of(homeProvider.myContext!)
                                .dismiss();
                            await HiveDb.setShowCase(false, ShowCasePages.home);
                            setState(() {});
                          }

                          homeProvider.currentPage = Constants.pagesList[1];
                          homeProvider.selectedBaseIndex = 1;
                          print(
                              "Your Base Selected Index = ${homeProvider.selectedBaseIndex}");
                          homeProvider.update();
                        },
                        description:
                            'monitor_and_track_your_cars_location_right_from_your_home_screen',
                        widget: googleMapBox(homeProvider)),
                  ],
                ),
              ),
            ),
          );
        },
        onStart: (index, p1) {
          if (index == (globalKeyList.length - 1)) {
            currentShowCaseIndex = int.parse("$index");
            setState(() {});
          }
        },
      );
    });
  }

  Widget carTempDetailBox() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shadowColor: R.appColors.lightGreyColor,
      color: R.appColors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 20.h,
        width: 90.w,
        decoration: R.decoration.generalDecoration(
            radius: 10, backgroundColor: R.appColors.black.withOpacity(0.06)),
        child: Row(
          children: [
            temperatureWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Audi A4",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: R.textStyles
                        .poppins(fontWeight: FontWeight.w600, fontSize: 17.sp),
                  ),
                  Text(
                    "${temperatureValue.ceil()}°F - ${getTemperatureResult()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: R.textStyles.poppins(
                        color: getColor(),
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Image.asset(
              R.appImages.carImg2,
              height: 105,
            )
          ],
        ),
      ),
    );
  }

  Widget temperatureWidget() {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: R.appColors.lightGreyColor,
                border: Border.all(
                  width: 3,
                  color: R.appColors.black,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: R.appColors.lightGreyColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: R.appColors.black,
                  )),
            ),
          ),
          Container(
            width: 16,
            height: 30,
            color: R.appColors.lightGreyColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: TemperatureWidget(
              temperatureValue: temperatureValue,
            ),
          )
        ],
      ),
    );
  }

  Widget googleMapBox(BasePagesSectionProvider homeProvider) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shadowColor: R.appColors.lightGreyColor,
      color: R.appColors.white,
      child: SizedBox(
        height: 30.h,
        width: 90.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GoogleMap(
            zoomControlsEnabled: false,
            markers: marker.toSet(),
            style: homeProvider.isDarkTheme
                ? Constants.mapStyleDark
                : Constants.mapStyleLight,
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }

  Widget childAvailableBox({
    required String childProfileImage,
    required String childName,
    required int childAge,
    required bool childAvailability,
    required int batteryPowerValue,
    required DeviceConnectionState deviceConnectionState,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: R.decoration.outLineDecoration(
          radius: 10,
          backgroundColor: R.appColors.white,
          borderColor:
              childAvailability ? R.appColors.greenColor : R.appColors.red),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(childProfileImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          childName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: R.textStyles.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                        Text(
                          "${"age_".L()} $childAge years",
                          style: R.textStyles.poppins(
                              fontWeight: FontWeight.w500, fontSize: 13.sp),
                        ),
                        Row(
                          children: [
                            connectedTypePicker(
                                deviceConnectionState:
                                    DeviceConnectionState.blueTooth),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "$batteryPowerValue%",
                              style: R.textStyles.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 13.sp),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            BasedBatteryIndicator(
                              status: BasedBatteryStatus(
                                value: batteryPowerValue,
                                type: getBatteryStatus(
                                    batteryValue: batteryPowerValue),
                              ),
                              trackHeight: 10.0,
                              trackAspectRatio: 2.0,
                              curve: Curves.ease,
                              duration: const Duration(seconds: 1),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                childAvailability
                    ? "child_in_seat".L()
                    : "no_child_detected".L(),
                style: R.textStyles.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: childAvailability
                        ? R.appColors.greenColor
                        : R.appColors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Icon connectedTypePicker(
      {required DeviceConnectionState deviceConnectionState}) {
    if (deviceConnectionState == DeviceConnectionState.blueTooth) {
      return Icon(
        Icons.bluetooth,
        size: 15,
        color: R.appColors.blueColor,
      );
    } else if (deviceConnectionState == DeviceConnectionState.wifi) {
      return Icon(
        Icons.wifi,
        size: 15,
        color: R.appColors.greenColor,
      );
    } else {
      return Icon(
        Icons.bluetooth,
        size: 15,
        color: R.appColors.iconsGreyColor,
      );
    }
  }

  BasedBatteryStatusType getBatteryStatus({required int batteryValue}) {
    if (batteryValue == 0) {
      return BasedBatteryStatusType.error;
    } else if (batteryValue > 0 && batteryValue <= 50) {
      return BasedBatteryStatusType.low;
    } else {
      return BasedBatteryStatusType.charging;
    }
  }

  String getTemperatureResult() {
    if (temperatureValue >= 0 && temperatureValue <= 30) {
      return "too_cold".L();
    } else if (temperatureValue > 30 && temperatureValue <= 80) {
      return "safe".L();
    } else {
      return "too_hot".L();
    }
  }

  Color getColor() {
    if (temperatureValue >= 0 && temperatureValue <= 30) {
      return R.appColors.lightBlue;
    } else if (temperatureValue > 30 && temperatureValue <= 80) {
      return R.appColors.greenColor;
    } else {
      return R.appColors.red;
    }
  }
}
