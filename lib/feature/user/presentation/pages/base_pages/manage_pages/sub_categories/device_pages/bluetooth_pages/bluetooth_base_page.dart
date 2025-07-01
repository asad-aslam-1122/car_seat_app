import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/device_info_list_model.dart';
import 'package:car_seat/feature/user/data/model/title_subtitle_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../../resources/resources.dart';
import '../../../../../../../../global/widget/custom_button.dart';
import '../qr_scan_pages/complete_setup_page.dart';

class BluetoothBasePage extends StatefulWidget {
  static String route = "/BluetoothBasePage";
  const BluetoothBasePage({super.key});

  @override
  State<BluetoothBasePage> createState() => _BluetoothBasePageState();
}

class _BluetoothBasePageState extends State<BluetoothBasePage> {
  List<TitleSubtitleModel> titleSubTitleList = [
    TitleSubtitleModel(
        title: "bluetooth_turned_off",
        subTitle: "please_turn_on_bluetooth_to_connect"),
    TitleSubtitleModel(
        title: "searching",
        subTitle:
            "scanning_for_nearby_devices_make_sure_your_device_is_powered_on_and_in_pairing_mode_to_connect"),
    TitleSubtitleModel(
        title: "no_device_found",
        subTitle: "please_turn_on_bluetooth_to_connect"),
  ];

  List<DeviceInfoListModel> deviceModel = [
    DeviceInfoListModel(
        title: "CSC Hardware 1",
        deviceBatteryStatus: 70,
        deviceStates: DeviceStates.connected,
        deviceImg: R.appImages.seatImg,
        assignedVehicle: "Honda Civic",
        assignedChild: "Tom Leech"),
    DeviceInfoListModel(
        title: "CSC Hardware 2",
        deviceBatteryStatus: 80,
        deviceStates: DeviceStates.connected,
        assignedVehicle: "Honda Civic",
        assignedChild: "Tom Leech",
        deviceImg: R.appImages.seatImg),
    DeviceInfoListModel(
        title: "CSC Hardware 3",
        deviceBatteryStatus: 100,
        assignedVehicle: "Honda Civic",
        assignedChild: "Tom Leech",
        deviceStates: DeviceStates.connected,
        deviceImg: R.appImages.seatImg),
  ];

  bool tryAgain = false;
  bool hasScanning = false;
  bool showDevicesList = false;
  bool isBluetoothEnabled = false;

  int indexValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tryAgain = false;
    hasScanning = false;
    showDevicesList = false;
    isBluetoothEnabled = false;
    indexValue = 0;
  }

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
                "add_device".L(),
                style: R.textStyles.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: R.appColors.white),
              ),
            ),
            body: Container(
              height: 100.h,
              width: 100.w,
              padding: const EdgeInsets.all(20),
              decoration: R.decoration
                  .topRadius(radius: 30, backgroundColor: R.appColors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        hasScanning = !hasScanning;
                        isBluetoothEnabled = !isBluetoothEnabled;

                        if (hasScanning && isBluetoothEnabled) {
                          indexValue = 1;
                        }

                        Future.delayed(
                          const Duration(seconds: 4),
                          () {
                            indexValue = 2;
                            hasScanning = false;
                            setState(() {});
                          },
                        );

                        setState(() {});
                      },
                      child: hasScanning && !showDevicesList
                          ? Lottie.asset(R.appImages.bluetoothAnimation,
                              height: 185)
                          : Image.asset(
                              R.appImages.bluetoothConnectionIcon,
                              height: 160,
                              color: isBluetoothEnabled
                                  ? themeColor.themeModel.themeColor
                                  : R.appColors.iconsGreyColor,
                            ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (!showDevicesList) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titleSubTitleList[indexValue].title.L(),
                            style: R.textStyles.poppins(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                          if (indexValue == 1)
                            Image.asset(
                              R.appImages.loadingDots,
                              color: R.appColors.black,
                              height: 50,
                              width: 30,
                            )
                        ],
                      ),
                      Text(
                        titleSubTitleList[indexValue].subTitle.L(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: R.textStyles.poppins(
                          color: R.appColors.textGreyColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                    if (showDevicesList) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "available_devices".L(),
                              style: R.textStyles.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: R.appColors.textGreyColor),
                            ),
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shrinkWrap: true,
                            itemCount: deviceModel.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      deviceModel[index].title,
                                      textAlign: TextAlign.center,
                                      style: R.textStyles.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                    GlobalWidgets.smallCustomButton(
                                        horizontalPad: 15,
                                        verticalPad: 5,
                                        textColor:
                                            themeColor.themeModel.themeColor,
                                        backGroundColor: themeColor
                                            .themeModel.themeColor
                                            .withOpacity(0.3),
                                        title: "pair",
                                        onPressed: () {
                                          Get.offAndToNamed(
                                              CompleteSetupDevice.route,
                                              arguments: {
                                                "isEditAble": false,
                                                "deviceModel":
                                                    deviceModel[index]
                                              });
                                        })
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: R.appColors.black.withOpacity(0.2),
                            ),
                          ),
                        ],
                      )
                    ],
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: isBluetoothEnabled && !hasScanning
                ? Container(
                    color: R.appColors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: CustomButton(
                        onPressed: () {
                          tryAgain = !tryAgain;
                          indexValue = 1;
                          hasScanning = true;
                          setState(() {});
                          Future.delayed(
                            const Duration(seconds: 3),
                            () {
                              showDevicesList = true;
                              setState(() {});
                            },
                          );
                        },
                        title: "try_again"),
                  )
                : null,
          ),
        );
      },
    );
  }
}
