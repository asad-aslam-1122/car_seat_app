import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';

class TitleWithButtonBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback onRightBtnPressed;
  final double? height;

  const TitleWithButtonBottomSheet(
      {super.key,
      required this.title,
      required this.onRightBtnPressed,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 26.h,
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      decoration: R.decoration
          .topRadius(radius: 35, backgroundColor: R.appColors.white),
      child: Column(
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
          Text(
            title.L(),
            textAlign: TextAlign.center,
            style: R.textStyles.poppins(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      showTextButton: true,
                      title: "no")),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomButton(onPressed: onRightBtnPressed, title: "yes"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
