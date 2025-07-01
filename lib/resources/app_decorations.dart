import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:car_seat/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../feature/user/presentation/provider/base_pages_section_provider.dart';

class Decorations {
  InputDecoration inputDecorationWithHint(
      {required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.black.withOpacity(0.2),
            width: 1,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.context!
                .read<BasePagesSectionProvider>()
                .themeModel
                .themeColor,
            width: 1,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.black.withOpacity(
                Get.context!.read<BasePagesSectionProvider>().isDarkTheme
                    ? 0.5
                    : 0.2),
            width: 1,
          )),
      suffixIcon: suffixIcon,
      hintText: hintText.L(),
      errorStyle: R.textStyles.poppins(fontSize: 14.sp, color: R.appColors.red),
      hintStyle: R.textStyles
          .poppins(fontSize: 16.sp, color: R.appColors.black.withOpacity(.3)),
    );
  }

  InputDecoration inputDecorationWithLabel(
      {required String labelText, Widget? suffixIcon}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.black.withOpacity(0.2),
            width: 1,
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Get.context!
                .read<BasePagesSectionProvider>()
                .themeModel
                .themeColor,
            width: 1,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.red,
            width: 1,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: R.appColors.black.withOpacity(
                Get.context!.read<BasePagesSectionProvider>().isDarkTheme
                    ? 0.5
                    : 0.2),
            width: 1,
          )),
      errorStyle: R.textStyles.poppins(fontSize: 14.sp, color: R.appColors.red),
      suffixIcon: suffixIcon,
      labelText: labelText.L(),
      hintStyle: R.textStyles
          .poppins(fontSize: 16.sp, color: R.appColors.black.withOpacity(.3)),
      labelStyle: R.textStyles.poppins(
          fontSize: 16.sp,
          color: R.appColors.black.withOpacity(
              Get.context!.read<BasePagesSectionProvider>().isDarkTheme
                  ? 0.5
                  : .38)),
    );
  }

  BoxDecoration bottomRadius(
      {required double radius, required Color backgroundColor}) {
    return BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)));
  }

  BoxDecoration topRadius(
      {required double radius, required Color backgroundColor}) {
    return BoxDecoration(
        color: backgroundColor,
        border: Border(
            top: BorderSide(
                color: Get.context!
                    .read<BasePagesSectionProvider>()
                    .themeModel
                    .themeColor)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)));
  }

  BoxDecoration generalDecoration(
      {required double radius, required Color backgroundColor}) {
    return BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(radius));
  }

  BoxDecoration generalShadowDecoration(
      {required double radius, required Color backgroundColor}) {
    return BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: R.appColors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 2)
        ]);
  }

  BoxDecoration outLineDecoration({
    required double radius,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius));
  }

  BoxDecoration circleShapeWithShadow(
      {required Color backgroundColor, required Color shadowColor}) {
    return BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 2, spreadRadius: 0.2, color: shadowColor)
        ]);
  }

  BoxDecoration circleShapeWithBorder({required Color borderColor}) {
    return BoxDecoration(
        color: R.appColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.2));
  }

  BoxDecoration rectangleShapeWithShadow(
      {required Color backgroundColor,
      required Color shadowColor,
      required double borderRadius}) {
    return BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(blurRadius: 15, spreadRadius: 4, color: shadowColor)
        ]);
  }
}
