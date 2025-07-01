import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import 'custom_radio_button/custom_radio_bottom.dart';
import 'global_widgets/global_widgets.dart';

class PreferenceAlertWidget extends StatefulWidget {
  String title;
  List<String> list;

  PreferenceAlertWidget({super.key, required this.title, required this.list});

  @override
  State<PreferenceAlertWidget> createState() => _PreferenceAlertWidgetState();
}

class _PreferenceAlertWidgetState extends State<PreferenceAlertWidget> {
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.appColors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: R.appColors.black.withOpacity(0.28),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 90.w,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                margin: const EdgeInsets.only(bottom: 30),
                decoration: R.decoration.generalDecoration(
                    radius: 10, backgroundColor: R.appColors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalWidgets.labelText(text: widget.title),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.list[index].L(),
                              style: R.textStyles.poppins(
                                color: R.appColors.textGreyColor,
                                fontSize: 15.sp,
                              ),
                            ),
                            CustomRadioBottom(
                                radioBtnId: widget.list[index],
                                radioGroupId: selectedValue,
                                onTab: () {
                                  selectedValue = widget.list[index];
                                  setState(() {});
                                }),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                      itemCount: widget.list.length,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "cancel".L(),
                            style: R.textStyles.poppins(
                                fontWeight: FontWeight.w500,
                                color: R.appColors.darkTextGreyColor,
                                fontSize: 16.sp),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
