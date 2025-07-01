import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../user/presentation/provider/base_pages_section_provider.dart';

class DropdownWidget extends StatefulWidget {
  final String? selectedValue;
  final String hintText;
  final bool isDisable;
  final List list;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;

  const DropdownWidget(
      {super.key,
      required this.selectedValue,
      required this.hintText,
      required this.onChanged,
      required this.list,
      this.isDisable = false,
      required this.validator});

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        selectedValue = widget.selectedValue;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2(
          iconStyleData: IconStyleData(
              icon: Image.asset(
                R.appImages.arrowDownIcon,
                scale: 3,
              ),
              openMenuIcon: Transform.flip(
                flipY: true,
                child: Image.asset(
                  R.appImages.arrowDownIcon,
                  scale: 3,
                ),
              )),
          style: R.textStyles.poppins(
            fontSize: 16.sp,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 1,
            offset: const Offset(-1, -10),
            decoration: BoxDecoration(
                color: R.appColors.white,
                border: Border.all(
                  color:
                      Get.context!.read<BasePagesSectionProvider>().isDarkTheme
                          ? Get.context!
                              .read<BasePagesSectionProvider>()
                              .themeModel
                              .themeColor
                          : R.appColors.transparent,
                ),
                borderRadius: BorderRadius.circular(12)),
          ),
          hint: Text(
            widget.hintText.L(),
            overflow: TextOverflow.ellipsis,
            style: R.textStyles.poppins(
                fontSize: 16.sp, color: R.appColors.black.withOpacity(.3)),
          ),
          validator: widget.validator,
          items: widget.list
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      style: R.textStyles.poppins(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                  ))
              .toList(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: selectedValue,
          onChanged: widget.isDisable == true ? null : widget.onChanged,
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          isDense: true,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 8),
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
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
                    color: R.appColors.black.withOpacity(Get.context!
                            .read<BasePagesSectionProvider>()
                            .isDarkTheme
                        ? 0.5
                        : 0.2),
                    width: 1,
                  )),
              errorStyle:
                  R.textStyles.poppins(fontSize: 14.sp, color: R.appColors.red),
              hintStyle: R.textStyles.poppins(
                  fontSize: 16.sp, color: R.appColors.black.withOpacity(.3)))),
    );
  }
}
