import 'package:car_seat/feature/global/widget/cards_widgets/device_card.dart';
import 'package:car_seat/feature/user/data/model/device_info_list_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../core_pages/empty_case_page.dart';

class DeviceBaseBody extends StatefulWidget {
  const DeviceBaseBody({
    super.key,
  });

  @override
  State<DeviceBaseBody> createState() => _DeviceBaseBodyState();
}

class _DeviceBaseBodyState extends State<DeviceBaseBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, manageDevicesList, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "manage_devices".L(),
              style: R.textStyles
                  .poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              "manage_all_your_connected_devices_easily".L(),
              style: R.textStyles.poppins(
                  color: R.appColors.textGreyColor,
                  fontWeight: FontWeight.w500),
            ),
            manageDevicesList.devicesList.isEmpty
                ? EmptyCasePage(
                    title: "no_device_found".L(),
                    subTitle: "add_a_device_for_real_time_monitoring".L(),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemBuilder: (context, index) {
                        DeviceInfoListModel deviceModel =
                            manageDevicesList.devicesList[index];

                        return DeviceCard(
                            deviceInfoListModel: deviceModel, index: index);
                      },
                      itemCount: manageDevicesList.devicesList.length,
                    ),
                  )
          ],
        );
      },
    );
  }
}
