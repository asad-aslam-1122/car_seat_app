import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../services/hive_services.dart';
import '../widget/global_widgets/global_widgets.dart';

class MyShowCaseWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final int currentGuideIndex;
  final BuildContext myContext;
  final String title;
  final ShowCasePages showCasePages;
  final bool? showArrowLeftSide;
  final double? targetBorderRadius;
  final Widget widget;
  final String description;
  final Function? onOkTap;
  final Function? onBackTap;
  final Function? onBarrierTab;
  final double? marginLeft;
  final double? width;
  final Function? onCloseFunc;
  TooltipPosition? tooltipPosition;
  final Colors? color;
  final bool hideBackButton;
  final bool showIndicatorInCenter;
  final bool? isDismiss;

  MyShowCaseWidget({
    super.key,
    required this.globalKey,
    required this.showCasePages,
    this.onBarrierTab,
    this.onCloseFunc,
    required this.currentGuideIndex,
    required this.myContext,
    required this.title,
    this.showArrowLeftSide = true,
    this.targetBorderRadius,
    required this.description,
    required this.widget,
    this.marginLeft,
    this.tooltipPosition,
    this.width,
    this.onOkTap,
    this.onBackTap,
    this.color,
    this.showIndicatorInCenter = false,
    this.hideBackButton = false,
    this.isDismiss = false,
  });

  @override
  Widget build(BuildContext _) {
    return Showcase.withWidget(
      onBarrierClick: () {
        onBarrierTab!();
      },
      disposeOnTap: false,
      disableDefaultTargetGestures: true,
      targetBorderRadius: BorderRadius.circular(targetBorderRadius ?? 6),
      tooltipPosition: tooltipPosition ?? TooltipPosition.bottom,
      toolTipSlideEndDistance: 15,
      overlayColor: R.appColors.black.withOpacity(0.28),
      key: globalKey,
      container: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if ((tooltipPosition ?? TooltipPosition.bottom) ==
              TooltipPosition.bottom) ...[
            if (!showIndicatorInCenter)
              Positioned(
                top: 5,
                left: showArrowLeftSide ?? false ? 16.w : null,
                right: showArrowLeftSide ?? false ? null : 16.w,
                child: Image.asset(
                  R.appImages.triangleImage,
                  color: R.appColors.white,
                  height: 15,
                  width: 20,
                ),
              ),
            if (showIndicatorInCenter)
              Positioned(
                top: 5,
                left: showArrowLeftSide ?? false ? ((width ?? 85.w) / 2) : null,
                right:
                    showArrowLeftSide ?? false ? null : ((width ?? 85.w) / 2),
                child: Image.asset(
                  R.appImages.triangleImage,
                  color: R.appColors.white,
                  height: 15,
                  width: 20,
                ),
              ),
          ],
          Align(
            alignment: Alignment.center,
            child: Container(
              width: width ?? 85.w,
              margin: EdgeInsets.only(
                  left: marginLeft ?? 10,
                  top: (tooltipPosition ?? TooltipPosition.bottom) ==
                          TooltipPosition.bottom
                      ? 15
                      : 0,
                  bottom: (tooltipPosition ?? TooltipPosition.bottom) ==
                          TooltipPosition.top
                      ? 15
                      : 0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: R.appColors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          title.L(),
                          style: R.textStyles.poppins(
                            color: R.appColors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: (isDismiss ?? false)
                              ? () {
                                  onCloseFunc!();
                                }
                              : () async {
                                  ShowCaseWidget.of(myContext).dismiss();
                                  await HiveDb.setShowCase(
                                      false, showCasePages);
                                  Get.forceAppUpdate();
                                },
                          child: Icon(
                            Icons.cancel,
                            size: 20,
                            color: R.appColors.iconsGreyColor,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 85.w,
                    child: Text(
                      description.L(),
                      style: R.textStyles.poppins(
                        color: Get.context!
                                .read<BasePagesSectionProvider>()
                                .isDarkTheme
                            ? R.appColors.black.withOpacity(.7)
                            : R.appColors.textGreyColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "$currentGuideIndex/18",
                          style: R.textStyles.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14.sp),
                        ),
                      ),
                      Row(
                        children: [
                          if (!hideBackButton)
                            GlobalWidgets.smallCustomButton(
                              verticalPad: 4,
                              horizontalPad: 12,
                              showBorder: true,
                              backGroundColor: myContext
                                  .read<BasePagesSectionProvider>()
                                  .themeModel
                                  .themeColor,
                              textColor: R.appColors.white,
                              onPressed: () {
                                onBackTap!();
                              },
                              title: "back",
                            ),
                          const SizedBox(
                            width: 4,
                          ),
                          GlobalWidgets.smallCustomButton(
                            verticalPad: 4,
                            horizontalPad: 12,
                            backGroundColor: myContext
                                .read<BasePagesSectionProvider>()
                                .themeModel
                                .themeColor,
                            textColor: R.appColors.white,
                            onPressed: () {
                              onOkTap!();
                            },
                            title: isDismiss == true ? "finish" : "next",
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if ((tooltipPosition ?? TooltipPosition.bottom) ==
              TooltipPosition.top)
            Positioned(
              bottom: 5,
              left: 16.w,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  R.appImages.triangleImage,
                  color: R.appColors.white,
                  height: 12,
                  width: 12,
                ),
              ),
            ),
        ],
      ),
      height: 0,
      width: 88.w,
      child: widget,
    );
  }
}
