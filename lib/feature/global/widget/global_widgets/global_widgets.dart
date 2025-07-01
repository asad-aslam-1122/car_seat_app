import 'package:car_seat/feature/global/widget/device_code_bottom_sheet.dart';
import 'package:car_seat/feature/global/widget/edit_profile_bottom_sheet.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../title_with_button_bottom_sheet.dart';

class GlobalWidgets {
  static Align labelText({required String text, FontWeight? fontWight}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text.L(),
          style: R.textStyles.poppins(
            fontSize: 16.sp,
            fontWeight: fontWight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }

  static void deviceCodeBottomSheet() {
    Get.bottomSheet(
      const DeviceCodeBottomSheet(),
    );
  }

  static void editProfileBottomSheet() {
    Get.bottomSheet(
      const EditProfileBottomSheet(),
    );
  }

  static void titleWithBtnBottomSheet(
      {required VoidCallback onRightBtnPressed,
      required String title,
      double? height}) {
    Get.bottomSheet(
      TitleWithButtonBottomSheet(
        title: title,
        height: height,
        onRightBtnPressed: onRightBtnPressed,
      ),
    );
  }

  static Widget smallCustomButton({
    required String title,
    required VoidCallback onPressed,
    Color? backGroundColor,
    bool? showBorder,
    Color? textColor,
    double? horizontalPad,
    double? verticalPad,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPad ?? 4, horizontal: horizontalPad ?? 8),
        decoration: R.decoration.outLineDecoration(
            radius: 5,
            borderColor: (showBorder ?? false)
                ? R.appColors.darkTextGreyColor
                : R.appColors.transparent,
            backgroundColor: (showBorder ?? false)
                ? R.appColors.transparent
                : (backGroundColor ?? R.appColors.lightGreyColor)),
        child: Text(
          title.L(),
          style: R.textStyles.poppins(
              fontWeight: FontWeight.w500,
              color: (showBorder ?? false)
                  ? R.appColors.darkTextGreyColor
                  : textColor ?? R.appColors.black),
        ),
      ),
    );
  }
}
