import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:car_seat/feature/user/data/model/device_info_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/qr_scan_pages/complete_setup_page.dart';
import '../../../user/presentation/provider/base_pages_section_provider.dart';
import '../../bot_toast/zbot_toast.dart';
import '../../constant/enums.dart';
import '../global_widgets/global_widgets.dart';

class DeviceCard extends StatefulWidget {
  final DeviceInfoListModel deviceInfoListModel;
  final int index;

  const DeviceCard(
      {super.key, required this.deviceInfoListModel, required this.index});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> with TickerProviderStateMixin {
  late SlidableController controller;

  @override
  void initState() {
    controller = SlidableController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BasePagesSectionProvider basePagesSectionProvider =
        Get.context!.read<BasePagesSectionProvider>();

    return Slidable(
      controller: controller,
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () {
              controller.close();
              Get.toNamed(CompleteSetupDevice.route, arguments: {
                "isEditAble": true,
                "index": widget.index,
                "deviceModel": widget.deviceInfoListModel
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(
                R.appImages.editIcon,
                color: Get.context!
                    .read<BasePagesSectionProvider>()
                    .themeModel
                    .themeColor,
                height: 25,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.close();

              GlobalWidgets.titleWithBtnBottomSheet(
                title: "are_you_sure_you_want_to_remove_this_device",
                onRightBtnPressed: () {
                  basePagesSectionProvider.devicesList.removeAt(widget.index);
                  basePagesSectionProvider.update();

                  ZBotToast.showCustomToast(context, "device_removed",
                      "device_has_been_removed_successfully");

                  Get.back();
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: Image.asset(
                R.appImages.deleteIcon,
                color: R.appColors.red,
                height: 25,
              ),
            ),
          )
        ],
      ),
      child: Card(
        color: R.appColors.white,
        elevation: 8,
        shadowColor: R.appColors.black.withOpacity(0.38),
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            subtitle: Row(
              children: [
                Text(
                  "${widget.deviceInfoListModel.deviceBatteryStatus}%",
                  style: R.textStyles.poppins(
                      fontWeight: FontWeight.w500,
                      color: R.appColors.textGreyColor),
                ),
                const SizedBox(
                  width: 5,
                ),
                BasedBatteryIndicator(
                  status: BasedBatteryStatus(
                    value: widget.deviceInfoListModel.deviceBatteryStatus,
                    type: getBatteryStatus(
                        batteryValue:
                            widget.deviceInfoListModel.deviceBatteryStatus),
                  ),
                  trackHeight: 10.0,
                  trackAspectRatio: 2.0,
                  curve: Curves.ease,
                  duration: const Duration(seconds: 1),
                ),
              ],
            ),
            title: Text(
              "${widget.index + 1}: ${widget.deviceInfoListModel.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles
                  .poppins(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.deviceInfoListModel.deviceImg),
            ),
            trailing: GlobalWidgets.smallCustomButton(
              title: widget.deviceInfoListModel.deviceStates ==
                      DeviceStates.connected
                  ? "connected"
                  : "disconnected",
              backGroundColor: widget.deviceInfoListModel.deviceStates ==
                      DeviceStates.connected
                  ? R.appColors.lightGreenColor
                  : R.appColors.lightGreyColor,
              textColor: widget.deviceInfoListModel.deviceStates ==
                      DeviceStates.connected
                  ? R.appColors.darkGreenColor
                  : basePagesSectionProvider.isDarkTheme
                      ? R.appColors.white
                      : R.appColors.black,
              onPressed: () {
                if (widget.deviceInfoListModel.deviceStates ==
                    DeviceStates.connected) {
                  Get.context!
                      .read<BasePagesSectionProvider>()
                      .devicesList[widget.index]
                      .deviceStates = DeviceStates.disConnected;
                } else {
                  Get.context!
                      .read<BasePagesSectionProvider>()
                      .devicesList[widget.index]
                      .deviceStates = DeviceStates.connected;
                }
                Get.context!.read<BasePagesSectionProvider>().update();
              },
            )),
      ),
    );
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
}
