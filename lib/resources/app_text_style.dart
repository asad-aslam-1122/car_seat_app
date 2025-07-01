import 'package:car_seat/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  TextStyle poppins(
      {TextDecoration? textDecoration,
      Color? color,
      double? fontSize,
      bool dontGiveTextHeight = false,
      FontWeight? fontWeight,
      double? letterSpacing,
      bool? needNoSpacing}) {
    return GoogleFonts.poppins(
      wordSpacing: (needNoSpacing ?? false) ? -5 : 0,
      fontSize: fontSize ?? 14.sp,
      color: color ?? R.appColors.black,
      height: dontGiveTextHeight ? null : 1.5,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0,
      decoration: textDecoration ?? TextDecoration.none,
    );
  }
}
