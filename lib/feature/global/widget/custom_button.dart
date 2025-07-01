import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class CustomButton extends StatefulWidget {
  VoidCallback onPressed;
  String title;
  double? textSize;
  FontWeight? textWeight;
  bool showTextButton;
  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;
  double? radius;
  double? height;
  double? width;
  Widget? iconWidget;
  bool isLocalizedText;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.textSize,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.radius,
      this.height,
      this.width,
      this.showTextButton = false,
      this.iconWidget,
      this.isLocalizedText = true,
      this.textWeight});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return widget.showTextButton
        ? SizedBox(
            height: widget.height ?? 50,
            width: widget.width ?? 80.w,
            child: TextButton(
                onPressed: widget.onPressed,
                style: ButtonStyle(
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                      (Set<WidgetState> states) {
                        return RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 12));
                      },
                    ),
                    side: WidgetStatePropertyAll(BorderSide(
                        color: widget.borderColor ??
                            R.appColors.black.withOpacity(0.38)))),
                child: widget.iconWidget != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.iconWidget ?? const SizedBox(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.isLocalizedText
                                ? widget.title.L()
                                : widget.title,
                            style: R.textStyles.poppins(
                                fontWeight:
                                    widget.textWeight ?? FontWeight.w600,
                                fontSize: widget.textSize ?? 16.sp,
                                color: widget.textColor ?? R.appColors.black),
                          ),
                        ],
                      )
                    : Text(
                        widget.isLocalizedText
                            ? widget.title.L()
                            : widget.title,
                        style: R.textStyles.poppins(
                            fontWeight: widget.textWeight ?? FontWeight.w600,
                            fontSize: widget.textSize ?? 16.sp,
                            color: widget.textColor ?? R.appColors.black),
                      )),
          )
        : SizedBox(
            height: widget.height ?? 50,
            width: widget.width ?? 80.w,
            child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ButtonStyle(
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                      (Set<WidgetState> states) {
                        return RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(widget.radius ?? 10));
                      },
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                        widget.backgroundColor ??
                            context
                                .read<BasePagesSectionProvider>()
                                .themeModel
                                .themeColor)),
                child: widget.iconWidget != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.iconWidget ?? const SizedBox(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.isLocalizedText
                                ? widget.title.L()
                                : widget.title,
                            style: R.textStyles.poppins(
                                fontWeight:
                                    widget.textWeight ?? FontWeight.w600,
                                fontSize: widget.textSize ?? 16.sp,
                                color: widget.textColor ?? R.appColors.white),
                          ),
                        ],
                      )
                    : Text(
                        widget.isLocalizedText
                            ? widget.title.L()
                            : widget.title,
                        style: R.textStyles.poppins(
                            fontWeight: widget.textWeight ?? FontWeight.w600,
                            fontSize: widget.textSize ?? 17.sp,
                            color: widget.textColor ?? R.appColors.white),
                      )),
          );
  }
}
