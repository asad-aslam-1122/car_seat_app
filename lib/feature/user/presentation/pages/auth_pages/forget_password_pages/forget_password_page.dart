import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/forget_password_pages/change_password_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/app_validator.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../global/widget/custom_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  static String route = "/ForgetPasswordPage";

  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTC = TextEditingController();

  FocusNode emailFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailFN.dispose();
    emailTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
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
                                "forgot_password".L(),
                                textAlign: TextAlign.center,
                                style: R.textStyles.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "enter_your_email_address_below_and_we_ll_send_you_a_link_to_reset_your_password"
                                    .L(),
                                textAlign: TextAlign.center,
                                style: R.textStyles.poppins(
                                  color: R.appColors.black.withOpacity(0.38),
                                  fontSize: 14.sp,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: emailTC,
                                focusNode: emailFN,
                                canRequestFocus: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: R.textStyles.poppins(
                                    fontSize: 16.sp, color: R.appColors.black),
                                decoration:
                                    R.decoration.inputDecorationWithLabel(
                                  labelText: "email",
                                ),
                                validator: AppValidator.validateEmail,
                              ),
                              const SizedBox(height: 35),
                              CustomButton(
                                width: 100.w,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ZBotToast.showCustomToast(
                                        context,
                                        "reset_link_sent",
                                        "a_password_reset_link_has_been_sent_to_your_email_please_check_your_inbox");
                                    Get.offAndToNamed(ChangePasswordPage.route);
                                  }
                                },
                                title: "send_reset_link",
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
