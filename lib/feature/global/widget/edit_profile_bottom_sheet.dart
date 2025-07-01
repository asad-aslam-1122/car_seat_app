import 'dart:io';

import 'package:car_seat/feature/global/bot_toast/zbot_toast.dart';
import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/feature/global/widget/image_picker/image_widget.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/app_validator.dart';
import '../../../resources/resources.dart';
import 'global_widgets/global_widgets.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameTC = TextEditingController();
  FocusNode fullNameFN = FocusNode();

  File? profileImage;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameFN.dispose();
    fullNameTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
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
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ImageWidget(
                      height: 90,
                      width: 90,
                      isFile: true,
                      isProfile: true,
                      isShowCamera: true,
                      uploadImage: (value) {
                        if (value != null) {
                          profileImage = value;
                          setState(() {});
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "edit_picture".L(),
                      style: R.textStyles
                          .poppins(color: R.appColors.textGreyColor),
                    ),
                  ),
                  GlobalWidgets.labelText(text: "full_name"),
                  TextFormField(
                    controller: fullNameTC,
                    focusNode: fullNameFN,
                    inputFormatters: [LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: R.textStyles
                        .poppins(fontSize: 16.sp, color: R.appColors.black),
                    decoration: R.decoration.inputDecorationWithLabel(
                      labelText: "full_name",
                    ),
                    validator: AppValidator.validateFullName,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      width: 100.w,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ZBotToast.showCustomToast(context, "profile_updated",
                              "profile_updated_successfully");
                          Get.back();
                        }
                      },
                      title: "update"),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
