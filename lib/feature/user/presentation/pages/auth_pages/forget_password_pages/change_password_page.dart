import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/forget_password_pages/congrajulation_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/password_state_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/app_validator.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../global/constant/enums.dart';
import '../../../../../global/widget/custom_button.dart';

class ChangePasswordPage extends StatefulWidget {
  static String route = "/ChangePasswordPage";

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  FocusNode passwordFN = FocusNode();
  FocusNode confirmPasswordFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    passwordTC.dispose();
    passwordFN.dispose();
    confirmPasswordFN.dispose();
    confirmPasswordTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordStateProvider, BasePagesSectionProvider>(
      builder: (context, passwordStateProvider, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: R.appColors.white,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 45.h,
                    decoration: R.decoration.bottomRadius(
                      backgroundColor: themeColor.themeModel.themeColor,
                      radius: 40,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: _formKey,
                      child: Card(
                        color: R.appColors.white,
                        elevation: 16,
                        shadowColor: R.appColors.black.withOpacity(0.5),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 18, left: 18, top: 30, bottom: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "change_password".L(),
                                textAlign: TextAlign.center,
                                style: R.textStyles.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "must_include_an_uppercase_letter_and_at_least_one_number_and_one_symbol"
                                    .L(),
                                textAlign: TextAlign.center,
                                style: R.textStyles.poppins(
                                  color: R.appColors.black.withOpacity(0.38),
                                  fontSize: 14.sp,
                                ),
                              ),
                              const SizedBox(height: 16),
                              GlobalWidgets.labelText(text: "new_password"),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                controller: passwordTC,
                                focusNode: passwordFN,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                style: R.textStyles.poppins(
                                    fontSize: 16.sp, color: R.appColors.black),
                                obscuringCharacter: '*',
                                obscureText: passwordStateProvider
                                            .passwordStateList[1] ==
                                        PasswordStates.hide
                                    ? true
                                    : false,
                                decoration:
                                    R.decoration.inputDecorationWithLabel(
                                        labelText: "new_password",
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              if (passwordStateProvider
                                                      .passwordStateList[1] ==
                                                  PasswordStates.hide) {
                                                passwordStateProvider
                                                        .passwordStateList[1] =
                                                    PasswordStates.show;
                                              } else {
                                                passwordStateProvider
                                                        .passwordStateList[1] =
                                                    PasswordStates.hide;
                                              }
                                              passwordStateProvider.update();
                                            },
                                            icon: Image.asset(
                                              passwordStateProvider
                                                              .passwordStateList[
                                                          1] ==
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                style: R.textStyles.poppins(
                                    fontSize: 16.sp, color: R.appColors.black),
                                obscuringCharacter: '*',
                                obscureText: passwordStateProvider
                                            .passwordStateList[2] ==
                                        PasswordStates.hide
                                    ? true
                                    : false,
                                decoration:
                                    R.decoration.inputDecorationWithLabel(
                                        labelText: "confirm_password",
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              if (passwordStateProvider
                                                      .passwordStateList[2] ==
                                                  PasswordStates.hide) {
                                                passwordStateProvider
                                                        .passwordStateList[2] =
                                                    PasswordStates.show;
                                              } else {
                                                passwordStateProvider
                                                        .passwordStateList[2] =
                                                    PasswordStates.hide;
                                              }
                                              passwordStateProvider.update();
                                            },
                                            icon: Image.asset(
                                              passwordStateProvider
                                                              .passwordStateList[
                                                          2] ==
                                                      PasswordStates.show
                                                  ? R.appImages.showIcon
                                                  : R.appImages.hideIcon,
                                              scale: 4,
                                            ))),
                                validator: (value) =>
                                    AppValidator.validatePasswordMatch(
                                        value, passwordTC.text),
                              ),
                              const SizedBox(height: 35),
                              CustomButton(
                                width: 100.w,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.offAllNamed(CongrajulationPage.route);
                                  }
                                },
                                title: "proceed",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: R.appColors.white,
                        size: 25,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded lineWidget({
    Color? lineColor,
    double? height,
  }) {
    return Expanded(
      child: Container(
        height: height ?? 1,
        color: lineColor ?? R.appColors.black,
      ),
    );
  }
}
