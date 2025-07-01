import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/app_validator.dart';
import '../../../resources/resources.dart';
import '../../user/presentation/pages/base_pages/manage_pages/sub_categories/device_pages/qr_scan_pages/complete_setup_page.dart';
import 'global_widgets/global_widgets.dart';

class DeviceCodeBottomSheet extends StatefulWidget {
  const DeviceCodeBottomSheet({super.key});

  @override
  State<DeviceCodeBottomSheet> createState() => _DeviceCodeBottomSheetState();
}

class _DeviceCodeBottomSheetState extends State<DeviceCodeBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController deviceCodeTC = TextEditingController();
  FocusNode deviceCodeFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deviceCodeFN.dispose();
    deviceCodeTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      decoration: R.decoration
          .topRadius(radius: 35, backgroundColor: R.appColors.white),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 4,
                width: 65,
                margin: const EdgeInsets.symmetric(vertical: 3.5),
                decoration: R.decoration.generalDecoration(
                    radius: 20,
                    backgroundColor: R.appColors.bottomSheetLineColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalWidgets.labelText(text: "device_code_"),
            TextFormField(
              controller: deviceCodeTC,
              focusNode: deviceCodeFN,
              canRequestFocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: R.textStyles
                  .poppins(fontSize: 16.sp, color: R.appColors.black),
              decoration: R.decoration.inputDecorationWithLabel(
                labelText: "device_code",
              ),
              validator: AppValidator.validateDeviceCode,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                width: 100.w,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.back();
                    Get.offAndToNamed(CompleteSetupDevice.route,
                        arguments: {"isEditAble": false});
                  }
                },
                title: "continue"),
          ],
        ),
      ),
    );
  }
}
