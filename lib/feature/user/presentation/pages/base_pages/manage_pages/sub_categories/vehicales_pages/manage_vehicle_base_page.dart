import 'package:based_battery_indicator/based_battery_indicator.dart';
import 'package:car_seat/feature/global/widget/cards_widgets/general_list_tile_card.dart';
import 'package:car_seat/feature/user/data/model/child_info_model.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/vehicales_pages/sub_pages/add_vehicle_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../global/widget/global_widgets/global_widgets.dart';
import '../../../../core_pages/empty_case_page.dart';

class ManageVehicleBasePage extends StatefulWidget {
  const ManageVehicleBasePage({
    super.key,
  });

  @override
  State<ManageVehicleBasePage> createState() => _ManageVehicleBasePageState();
}

class _ManageVehicleBasePageState extends State<ManageVehicleBasePage>
    with TickerProviderStateMixin {
  late SlidableController controller;

  @override
  void initState() {
    controller = SlidableController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, manageVehicleList, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "manage_vehicles".L(),
              style: R.textStyles
                  .poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              "manage_all_your_vehicles_easily".L(),
              style: R.textStyles.poppins(
                  color: R.appColors.textGreyColor,
                  fontWeight: FontWeight.w500),
            ),
            manageVehicleList.vehicleList.isEmpty
                ? EmptyCasePage(
                    title: "no_vehicle_found".L(),
                    subTitle: "add_a_vehicle_for_real_time_monitoring".L(),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemBuilder: (context, index) {
                        ListTileModel vehicleModel =
                            manageVehicleList.vehicleList[index];

                        // vehicleModel.title =
                        //     "${vehicleModel.title} ${vehicleModel.careModel} ${vehicleModel.carYear}";

                        return GeneralLisTileCard(
                          onRemoveItemTab: () {
                            GlobalWidgets.titleWithBtnBottomSheet(
                                onRightBtnPressed: () {
                                  manageVehicleList.vehicleList.removeAt(index);
                                  manageVehicleList.update();
                                  ZBotToast.showCustomToast(
                                      context,
                                      "vehicle_removed",
                                      "vehicle_has_been_removed_successfully");
                                  Get.back();
                                },
                                title:
                                    "are_you_sure_you_want_to_remove_this_vehicle_");
                          },
                          onEditItemTab: () {
                            Get.toNamed(AddVehiclePage.route, arguments: {
                              "isEditAble": true,
                              "index": index,
                              "vehicleModel": vehicleModel
                            });
                          },
                          isVehicleModel: true,
                          index: index,
                          listTileModel: vehicleModel,
                        );
                      },
                      itemCount: manageVehicleList.vehicleList.length,
                    ),
                  )
          ],
        );
      },
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
