import 'dart:io';

import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/child_info_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../../resources/app_validator.dart';
import '../../../../../../../../../resources/resources.dart';
import '../../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../../global/widget/custom_button.dart';
import '../../../../../../../../global/widget/image_picker/image_widget.dart';

class AddChildPage extends StatefulWidget {
  static String route = "/AddChildPage";
  const AddChildPage({super.key});

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  File? profileImage;
  bool isValidate = false;
  bool isEditAble = false;
  int index = 0;

  TextEditingController dateOfBirthTC = TextEditingController();
  TextEditingController childNameTC = TextEditingController();

  FocusNode dateOfBirthFN = FocusNode();
  FocusNode childNameFN = FocusNode();
  DateTime initialDate = DateTime.now();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  ListTileModel? childModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEditAble = Get.arguments["isEditAble"];
    index = Get.arguments["index"];
    childModel = Get.arguments["childModel"];

    if (childModel != null) {
      isValidate = true;
      nameValidate = true;
      profileImage = childModel?.profileImg ?? File("");
      childNameTC.text = childModel?.title ?? "";
      dateOfBirthTC.text = DateFormat("dd / MM / yyyy").format(
          DateTime.fromMillisecondsSinceEpoch(
              int.parse(childModel?.subTitle ?? "")));
      selectedDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(childModel?.subTitle ?? ""));
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateOfBirthFN.dispose();
    dateOfBirthTC.dispose();
    childNameTC.dispose();
    childNameFN.dispose();
  }

  bool nameValidate = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, addChildProvider, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: addChildProvider.themeModel.themeColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: addChildProvider.themeModel.themeColor,
              surfaceTintColor: addChildProvider.themeModel.themeColor,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: R.appColors.white,
                  )),
              title: Text(
                isEditAble ? "edit_child".L() : "add_child".L(),
                style: R.textStyles.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: R.appColors.white),
              ),
            ),
            body: Container(
                height: 100.h,
                width: 100.w,
                decoration: R.decoration
                    .topRadius(radius: 30, backgroundColor: R.appColors.white),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            isEditAble
                                ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(profileImage!),
                                            fit: BoxFit.cover)),
                                    height: 60,
                                    width: 60,
                                  )
                                : ImageWidget(
                                    height: 60,
                                    width: 60,
                                    isShowCamera: false,
                                    isFile: true,
                                    uploadImage: (value) {
                                      if (value != null) {
                                        profileImage = value;
                                        isValidate = false;
                                        setState(() {});
                                      }
                                    }),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "profile_picture".L(),
                                  style: R.textStyles.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "click_to_upload_an_image".L(),
                                  style: R.textStyles.poppins(
                                      color: R.appColors.textGreyColor),
                                ),
                                if (!(profileImage != null ||
                                    isValidate == false))
                                  Text(
                                    "please_upload_profile_image".L(),
                                    style: R.textStyles.poppins(
                                        fontSize: 14.sp,
                                        color: R.appColors.red),
                                  ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GlobalWidgets.labelText(text: "child_name"),
                        TextFormField(
                          controller: childNameTC,
                          focusNode: childNameFN,
                          canRequestFocus: true,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onChanged: (newValue) {
                            if (childNameTC.text.isNotEmpty) {
                              nameValidate = true;
                            } else {
                              nameValidate = false;
                            }
                            setState(() {});
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: R.textStyles.poppins(
                              fontSize: 16.sp, color: R.appColors.black),
                          decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "child_name_",
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          validator: AppValidator.validateFullName,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GlobalWidgets.labelText(text: "date_of_birth"),
                        TextFormField(
                          readOnly: true,
                          onTap: () {
                            showCalenderPopup(addChildProvider);
                          },
                          style: R.textStyles.poppins(
                              fontSize: 16.sp, color: R.appColors.black),
                          controller: dateOfBirthTC,
                          focusNode: dateOfBirthFN,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: AppValidator.validateDOB,
                          decoration: R.decoration.inputDecorationWithLabel(
                              labelText: "enter_date_of_birth",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    showCalenderPopup(addChildProvider);
                                  },
                                  icon: Image.asset(
                                    R.appImages.calenderIcon,
                                    height: 23,
                                    width: 24,
                                    color: R.appColors.iconsGreyColor,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                )),
            bottomNavigationBar: Container(
              color: R.appColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Opacity(
                opacity: (profileImage != null &&
                        nameValidate &&
                        dateOfBirthTC.text.trim().isNotEmpty)
                    ? 1
                    : 0.5,
                child: CustomButton(
                    onPressed: (profileImage != null &&
                            nameValidate &&
                            dateOfBirthTC.text.trim().isNotEmpty)
                        ? () {
                            if (_formKey.currentState!.validate() &&
                                profileImage != null) {
                              ListTileModel childInfo = ListTileModel(
                                subTitle: selectedDate!.millisecondsSinceEpoch
                                    .toString(),
                                title: childNameTC.text,
                                profileImg: profileImage!,
                              );

                              if (isEditAble) {
                                addChildProvider.childrenList[index] =
                                    childInfo;
                                ZBotToast.showCustomToast(
                                    context,
                                    'child_updated',
                                    "child_has_been_updated_successfully");
                              } else {
                                addChildProvider.childrenList.add(childInfo);
                                ZBotToast.showCustomToast(
                                    context,
                                    'child_added',
                                    "child_has_been_added_successfully");
                              }

                              addChildProvider.update();

                              Get.back();
                            } else {
                              setState(() {
                                isValidate = true;
                              });
                            }
                          }
                        : () {},
                    title: isEditAble ? "update" : "add"),
              ),
            ),
          ),
        );
      },
    );
  }

  void showCalenderPopup(BasePagesSectionProvider provider) {
    if (selectedDate != null) {
      initialDate = selectedDate!;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 260,
        decoration: R.decoration.topRadius(
          radius: 30,
          backgroundColor: R.appColors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  child: Text(
                    'Done',
                    style: R.textStyles.poppins(
                        fontSize: 18.sp,
                        color: provider.themeModel.themeColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Get.back();
                    selectedDate = initialDate;
                    dateOfBirthTC.text =
                        DateFormat("dd / MM / yyyy").format(selectedDate!);
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: CupertinoTheme(
                data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: R.textStyles.poppins(
                      fontSize: 16.sp,
                      color: R.appColors.black,
                      fontWeight: FontWeight.w600),
                )),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    initialDate = newDate;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
