import 'package:car_seat/feature/global/widget/custom_radio_button/custom_radio_bottom.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../user/presentation/provider/onboard_provider.dart';
import 'custom_button.dart';

class ChangeLanguageWidget extends StatefulWidget {
  final OnBoardProvider onboardProvider;
  final VoidCallback onBtnPressed;
  final bool? giveMargin;

  const ChangeLanguageWidget(
      {super.key,
      required this.onboardProvider,
      required this.onBtnPressed,
      this.giveMargin});

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  List<String> languagesList = ["english", "spanish"];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.appColors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 100.w,
          padding: const EdgeInsets.all(20),
          margin: (widget.giveMargin ?? false)
              ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
              : null,
          decoration: BoxDecoration(
              border: Border.all(
                  color: context
                      .read<BasePagesSectionProvider>()
                      .themeModel
                      .themeColor),
              borderRadius: BorderRadius.circular(10),
              color: R.appColors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "choose_language".L(),
                style: R.textStyles.poppins(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "please_select_a_language_to_continue".L(),
                style: R.textStyles.poppins(
                    color: context.read<BasePagesSectionProvider>().isDarkTheme
                        ? R.appColors.black.withOpacity(.7)
                        : R.appColors.textGreyColor,
                    fontSize: 15.sp),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 150, // Adjust as needed
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final selectedLanguage =
                        context.watch<OnBoardProvider>().selectedLanguage;
                    return ListTile(
                      dense: true,
                      title: Text(
                        languagesList[index].L(),
                        style: R.textStyles.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: R.appColors.darkTextGreyColor),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      trailing: CustomRadioBottom(
                          radioBtnId: languagesList[index],
                          radioGroupId: selectedLanguage,
                          onTab: () {
                            widget.onboardProvider.selectedLanguage =
                                languagesList[index];
                            widget.onboardProvider.update();
                          }),
                      // trailing: Radio<String>(
                      //   value: languagesList[index],
                      //   groupValue: selectedLanguage,
                      //   onChanged: (selectedLanguage) {
                      //     widget.onboardProvider.selectedLanguage =
                      //         selectedLanguage!;
                      //     widget.onboardProvider.update();
                      //   },
                      //   visualDensity: VisualDensity.compact,
                      //   activeColor: context
                      //       .read<BasePagesSectionProvider>()
                      //       .themeModel
                      //       .themeColor,
                      // ),
                    );
                  },
                  itemCount: languagesList.length,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                  child: CustomButton(
                      onPressed: widget.onBtnPressed, title: "confirm"))
            ],
          ),
        ),
      ),
    );
  }
}
