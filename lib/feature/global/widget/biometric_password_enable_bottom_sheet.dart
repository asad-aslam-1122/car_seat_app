import 'package:car_seat/feature/global/bot_toast/zbot_toast.dart';
import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/password_state_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/app_validator.dart';
import '../../../resources/resources.dart';
import '../../user/presentation/pages/auth_pages/forget_password_pages/forget_password_page.dart';
import '../constant/enums.dart';

class BiometricPasswordEnableBottomSheet extends StatefulWidget {
  const BiometricPasswordEnableBottomSheet({super.key});

  @override
  State<BiometricPasswordEnableBottomSheet> createState() =>
      _BiometricPasswordEnableBottomSheetState();
}

class _BiometricPasswordEnableBottomSheetState
    extends State<BiometricPasswordEnableBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordTC = TextEditingController();

  FocusNode passwordFN = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordTC.dispose();
    passwordFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordStateProvider, BasePagesSectionProvider>(
      builder:
          (context, passwordVisibilityProvider, biometricValueProvider, child) {
        return Container(
          height: 38.h,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "password_required".L(),
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "enter_your_password_to_enable_biometric_login".L(),
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w600,
                            color: R.appColors.textGreyColor),
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
                        obscureText:
                            passwordVisibilityProvider.passwordStateList[0] ==
                                    PasswordStates.hide
                                ? true
                                : false,
                        decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordVisibilityProvider
                                          .passwordStateList[0] ==
                                      PasswordStates.hide) {
                                    passwordVisibilityProvider
                                            .passwordStateList[0] =
                                        PasswordStates.show;
                                  } else {
                                    passwordVisibilityProvider
                                            .passwordStateList[0] =
                                        PasswordStates.hide;
                                  }
                                  passwordVisibilityProvider.update();
                                },
                                icon: Icon(
                                    passwordVisibilityProvider
                                                .passwordStateList[0] ==
                                            PasswordStates.show
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: R.appColors.iconsGreyColor))),
                        validator: AppValidator.validatePassword,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(ForgetPasswordPage.route);
                          },
                          child: Text(
                            "forgot_password".L(),
                            textAlign: TextAlign.center,
                            style: R.textStyles.poppins(
                                fontSize: 14.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: CustomButton(
                              onPressed: () {
                                biometricValueProvider.bioMetricLogin =
                                    !biometricValueProvider.bioMetricLogin;
                                biometricValueProvider.update();

                                if (biometricValueProvider.bioMetricLogin ==
                                    true) {
                                  ZBotToast.showCustomToast(
                                      context,
                                      "biometrics_login_enabled",
                                      "biometrics_login_has_been_enabled_successfully");
                                } else {
                                  ZBotToast.showCustomToast(
                                      context,
                                      "biometrics_login_disabled",
                                      "biometrics_login_has_been_disabled_successfully");
                                }

                                Get.back();
                              },
                              title: "continue"))
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
