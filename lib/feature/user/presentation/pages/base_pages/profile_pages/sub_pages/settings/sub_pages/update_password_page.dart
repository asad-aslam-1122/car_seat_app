import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/password_state_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../../resources/app_validator.dart';
import '../../../../../../../../../resources/resources.dart';
import '../../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../../global/constant/enums.dart';
import '../../../../../../../../global/widget/custom_button.dart';

class UpdatePasswordPage extends StatefulWidget {
  static String route = "/UpdatePasswordPage";
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController newPasswordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  FocusNode passwordFN = FocusNode();
  FocusNode newPasswordFN = FocusNode();
  FocusNode confirmPasswordFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    passwordTC.dispose();
    passwordFN.dispose();
    newPasswordFN.dispose();
    newPasswordTC.dispose();
    confirmPasswordFN.dispose();
    confirmPasswordTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordStateProvider, BasePagesSectionProvider>(
      builder: (context, passwordStateProvider, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: themeColor.themeModel.themeColor,
            appBar: AppBar(
              backgroundColor: themeColor.themeModel.themeColor,
              surfaceTintColor: themeColor.themeModel.themeColor,
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
                "change_password".L(),
                style: R.textStyles.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: R.appColors.white),
              ),
            ),
            body: SafeArea(
              child: Container(
                height: 100.h,
                width: 100.w,
                padding: const EdgeInsets.all(20),
                decoration: R.decoration
                    .topRadius(radius: 30, backgroundColor: R.appColors.white),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalWidgets.labelText(
                          text: "enter_your_current_password_"),
                      TextFormField(
                        controller: passwordTC,
                        focusNode: passwordFN,
                        canRequestFocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        style: R.textStyles
                            .poppins(fontSize: 16.sp, color: R.appColors.black),
                        obscuringCharacter: '*',
                        obscureText:
                            passwordStateProvider.passwordStateList[0] ==
                                    PasswordStates.hide
                                ? true
                                : false,
                        decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "current_password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (passwordStateProvider
                                          .passwordStateList[0] ==
                                      PasswordStates.hide) {
                                    passwordStateProvider.passwordStateList[0] =
                                        PasswordStates.show;
                                  } else {
                                    passwordStateProvider.passwordStateList[0] =
                                        PasswordStates.hide;
                                  }
                                  passwordStateProvider.update();
                                },
                                icon: Image.asset(
                                  passwordStateProvider.passwordStateList[0] ==
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
                      GlobalWidgets.labelText(text: "enter_your_new_password_"),
                      TextFormField(
                        controller: newPasswordTC,
                        focusNode: newPasswordFN,
                        canRequestFocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        style: R.textStyles
                            .poppins(fontSize: 16.sp, color: R.appColors.black),
                        obscuringCharacter: '*',
                        obscureText:
                            passwordStateProvider.passwordStateList[1] ==
                                    PasswordStates.hide
                                ? true
                                : false,
                        decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "new_password",
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
                        canRequestFocus: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        style: R.textStyles
                            .poppins(fontSize: 16.sp, color: R.appColors.black),
                        obscuringCharacter: '*',
                        obscureText:
                            passwordStateProvider.passwordStateList[2] ==
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
                        validator: (value) =>
                            AppValidator.validatePasswordMatch(
                                value, newPasswordTC.text),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: R.appColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ZBotToast.showCustomToast(context, 'password_changed',
                          "password_has_been_changed_successfully");
                      Get.back();
                    }
                  },
                  title: "change"),
            ),
          ),
        );
      },
    );
  }
}
