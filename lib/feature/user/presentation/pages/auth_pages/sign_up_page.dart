import 'dart:io';

import 'package:car_seat/feature/global/bot_toast/zbot_toast.dart';
import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/feature/global/widget/image_picker/image_widget.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/add_emergency_contact_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/password_state_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_validator.dart';
import '../../../../../resources/resources.dart';
import '../../../../global/constant/enums.dart';
import '../../../../global/widget/custom_radio_button/custom_radio_bottom.dart';
import '../../../../global/widget/drop_down_widget.dart';
import '../terms_and_privacy_pages/terms_and_conditions.dart';

class SignUpPage extends StatefulWidget {
  static String route = "/SignUpPage";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> carMakeList = ["Audi", "BMW", "Chery", "Datsun", "Ford", "GMC"];
  // PhoneNumber number = PhoneNumber();
  String? selectedCarMake;
  String? selectedCarModel;
  String? selectedCarYear;

  List<String> carModelList = [
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
  ];

  List<String> carYearList = [
    "2024",
    "2023",
    "2022",
    "2021",
  ];

  File? profileImage;
  bool isValidate = false;
  TextEditingController fullNameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  TextEditingController licensePlateTC = TextEditingController();

  FocusNode fullNameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode phoneFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode confirmPasswordFN = FocusNode();
  FocusNode licensePlateFN = FocusNode();

  bool isAgree = false;

  @override
  void dispose() {
    super.dispose();
    passwordFN.dispose();
    passwordTC.dispose();
    confirmPasswordFN.dispose();
    confirmPasswordTC.dispose();
    phoneFN.dispose();
    phoneTC.dispose();
    emailTC.dispose();
    emailFN.dispose();
    fullNameFN.dispose();
    fullNameTC.dispose();
    licensePlateFN.dispose();
    licensePlateTC.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordStateProvider, BasePagesSectionProvider>(
      builder: (context, passwordStateProvider, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: R.appColors.white,
            appBar: AppBar(
              backgroundColor: themeColor.themeModel.themeColor,
              surfaceTintColor: themeColor.themeModel.themeColor,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: R.appColors.white,
                    size: 25,
                  )),
              centerTitle: true,
              title: Text(
                "sign_up".L(),
                textAlign: TextAlign.center,
                style: R.textStyles.poppins(
                    fontSize: 18.sp,
                    color: R.appColors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ImageWidget(
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
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "click_to_upload_an_image".L(),
                              style: R.textStyles
                                  .poppins(color: R.appColors.textGreyColor),
                            ),
                            if (!(profileImage != null || isValidate == false))
                              Text(
                                "please_upload_profile_image".L(),
                                style: R.textStyles.poppins(
                                    fontSize: 14.sp, color: R.appColors.red),
                              ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: fullNameTC,
                      focusNode: fullNameFN,
                      canRequestFocus: true,
                      keyboardType: TextInputType.name,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: R.textStyles
                          .poppins(fontSize: 16.sp, color: R.appColors.black),
                      decoration: R.decoration.inputDecorationWithLabel(
                          labelText: "full_name",
                          suffixIcon: Image.asset(
                            R.appImages.personIcon,
                            scale: 4,
                          )),
                      validator: AppValidator.validateFullName,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: emailTC,
                      focusNode: emailFN,
                      canRequestFocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: R.textStyles
                          .poppins(fontSize: 16.sp, color: R.appColors.black),
                      decoration: R.decoration.inputDecorationWithLabel(
                        labelText: "email",
                        suffixIcon: Image.asset(
                          R.appImages.emailIcon,
                          scale: 4,
                        ),
                      ),
                      validator: AppValidator.validateEmail,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // PhoneNumberPicker(
                    //   controller: phoneTC,
                    //   focusNode: phoneFN,
                    //   isShowSuffix: true,
                    //   phoneNumber: (pNumber) {
                    //     number = pNumber;
                    //   },
                    // ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: DropdownWidget(
                          hintText: "car_make",
                          list: carMakeList,
                          onChanged: (selectedValue) {
                            setState(() {
                              selectedCarMake = selectedValue!;
                            });
                          },
                          validator: AppValidator.validateDropdown,
                          selectedValue: selectedCarMake,
                        )),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: DropdownWidget(
                          hintText: "car_model",
                          list: carModelList,
                          onChanged: (selectedValue) {
                            setState(() {
                              selectedCarModel = selectedValue!;
                            });
                          },
                          validator: AppValidator.validateDropdown,
                          selectedValue: selectedCarModel,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: DropdownWidget(
                          hintText: "car_year",
                          list: carYearList,
                          onChanged: (selectedValue) {
                            setState(() {
                              selectedCarYear = selectedValue!;
                            });
                          },
                          validator: AppValidator.validateDropdown,
                          selectedValue: selectedCarYear,
                        )),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: licensePlateTC,
                            focusNode: licensePlateFN,
                            canRequestFocus: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: R.textStyles.poppins(
                                fontSize: 16.sp, color: R.appColors.black),
                            decoration: R.decoration.inputDecorationWithLabel(
                              labelText: "license_plate",
                            ),
                            validator: AppValidator.validateLicense,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: passwordTC,
                      focusNode: passwordFN,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles
                          .poppins(fontSize: 16.sp, color: R.appColors.black),
                      obscuringCharacter: '*',
                      obscureText: passwordStateProvider.passwordStateList[1] ==
                              PasswordStates.hide
                          ? true
                          : false,
                      decoration: R.decoration.inputDecorationWithLabel(
                          labelText: "password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (passwordStateProvider
                                        .passwordStateList[1] ==
                                    PasswordStates.hide) {
                                  passwordStateProvider.passwordStateList[1] =
                                      PasswordStates.show;
                                } else {
                                  passwordStateProvider.passwordStateList[1] =
                                      PasswordStates.hide;
                                }
                                passwordStateProvider.update();
                              },
                              icon: Image.asset(
                                passwordStateProvider.passwordStateList[1] ==
                                        PasswordStates.show
                                    ? R.appImages.showIcon
                                    : R.appImages.hideIcon,
                                scale: 4,
                              ))),
                      validator: AppValidator.validatePassword,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: confirmPasswordTC,
                      focusNode: confirmPasswordFN,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      style: R.textStyles
                          .poppins(fontSize: 16.sp, color: R.appColors.black),
                      obscuringCharacter: '*',
                      obscureText: passwordStateProvider.passwordStateList[2] ==
                              PasswordStates.hide
                          ? true
                          : false,
                      decoration: R.decoration.inputDecorationWithLabel(
                          labelText: "confirm_password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (passwordStateProvider
                                        .passwordStateList[2] ==
                                    PasswordStates.hide) {
                                  passwordStateProvider.passwordStateList[2] =
                                      PasswordStates.show;
                                } else {
                                  passwordStateProvider.passwordStateList[2] =
                                      PasswordStates.hide;
                                }
                                passwordStateProvider.update();
                              },
                              icon: Image.asset(
                                passwordStateProvider.passwordStateList[2] ==
                                        PasswordStates.show
                                    ? R.appImages.showIcon
                                    : R.appImages.hideIcon,
                                scale: 4,
                              ))),
                      validator: (value) => AppValidator.validatePasswordMatch(
                          value, passwordTC.text),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        CustomRadioBottom(
                            radioBtnId: true,
                            radioGroupId: isAgree,
                            onTab: () {
                              isAgree = !isAgree;
                              setState(() {});
                            }),
                        const SizedBox(
                          width: 8,
                        ),
                        RichText(
                          text: TextSpan(
                              style: R.textStyles.poppins(
                                  color: R.appColors.textGreyColor,
                                  fontSize: 15.sp),
                              children: [
                                TextSpan(
                                  text: "I_agree_with".L(),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(TermsAndConditions.route,
                                          arguments: {
                                            "pageTitle": "terms_of_use"
                                          });
                                    },
                                  text: "terms_of_use".L(),
                                  style: R.textStyles.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        profileImage != null) {
                      if (isAgree) {
                        ZBotToast.showCustomToast(context, "congratulations",
                            "signed_up_successfully");
                        Get.offAndToNamed(AddEmergencyContactPage.route,
                            arguments: {
                              "appBarTitle": "add_emergency_contact",
                              "isEditAble": false,
                              "isFromSignUp": true,
                              "index": 0
                            });
                      } else {
                        ZBotToast.showToastError(
                            message: "please_accept_the_terms_and_conditions");
                      }
                    } else {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  },
                  title: "sign_up"),
            ),
          ),
        );
      },
    );
  }
}
