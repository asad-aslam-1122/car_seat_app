import 'package:car_seat/feature/app/base_page.dart';
import 'package:car_seat/feature/global/widget/custom_button.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/sign_up_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/feature/user/presentation/provider/password_state_provider.dart';
import 'package:car_seat/resources/app_validator.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../global/constant/enums.dart';
import 'forget_password_pages/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  static String route = "/LoginPage";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> imgList = [
    R.appImages.googleIcon,
    R.appImages.appleIcon,
    R.appImages.faceIcon,
    R.appImages.fingerPrintIcon,
  ];

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTC = TextEditingController();

  TextEditingController passwordTC = TextEditingController();

  FocusNode emailFN = FocusNode();

  FocusNode passwordFN = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailFN.dispose();
    emailTC.dispose();
    passwordFN.dispose();
    passwordTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PasswordStateProvider, BasePagesSectionProvider>(
      builder: (context, passwordStateProvider, themeColor, child) {
        return SafeAreaWidget(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: themeColor.themeModel.themeColor,
              surfaceTintColor: themeColor.themeModel.themeColor,
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: R.appColors.white,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                      height: 26.h,
                      decoration: R.decoration.bottomRadius(
                          backgroundColor: themeColor.themeModel.themeColor,
                          radius: 40)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: Card(
                              color: R.appColors.white,
                              elevation: 16,
                              shadowColor: R.appColors.black.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "welcome_back".L(),
                                      textAlign: TextAlign.center,
                                      style: R.textStyles.poppins(
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "account_login".L(),
                                      textAlign: TextAlign.center,
                                      style: R.textStyles.poppins(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    TextFormField(
                                      controller: emailTC,
                                      focusNode: emailFN,
                                      canRequestFocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: R.textStyles.poppins(
                                          fontSize: 16.sp,
                                          color: R.appColors.black),
                                      decoration:
                                          R.decoration.inputDecorationWithLabel(
                                        labelText: "email",
                                      ),
                                      validator: AppValidator.validateEmail,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextFormField(
                                      controller: passwordTC,
                                      focusNode: passwordFN,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      style: R.textStyles.poppins(
                                          fontSize: 16.sp,
                                          color: R.appColors.black),
                                      obscuringCharacter: '*',
                                      obscureText: passwordStateProvider
                                                  .passwordStateList[0] ==
                                              PasswordStates.hide
                                          ? true
                                          : false,
                                      decoration: R.decoration
                                          .inputDecorationWithLabel(
                                              labelText: "password",
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    if (passwordStateProvider
                                                                .passwordStateList[
                                                            0] ==
                                                        PasswordStates.hide) {
                                                      passwordStateProvider
                                                              .passwordStateList[
                                                          0] = PasswordStates.show;
                                                    } else {
                                                      passwordStateProvider
                                                              .passwordStateList[
                                                          0] = PasswordStates.hide;
                                                    }
                                                    passwordStateProvider
                                                        .update();
                                                  },
                                                  icon: Icon(
                                                      passwordStateProvider
                                                                      .passwordStateList[
                                                                  0] ==
                                                              PasswordStates
                                                                  .show
                                                          ? Icons
                                                              .visibility_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: R.appColors
                                                          .iconsGreyColor))),
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
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    CustomButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Get.offAllNamed(BasePage.route);
                                          }
                                        },
                                        title: "login")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            children: [
                              lineWidget(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "or_login_with".L(),
                                  textAlign: TextAlign.center,
                                  style: R.textStyles.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              lineWidget(),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                imgList.length,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: R.decoration
                                        .circleShapeWithShadow(
                                            backgroundColor: R.appColors.white,
                                            shadowColor:
                                                R.appColors.iconsGreyColor),
                                    child: Image.asset(
                                      imgList[index],
                                      scale: 5,
                                      color:
                                          index == 0 ? null : R.appColors.black,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          RichText(
                            text: TextSpan(
                                style: R.textStyles.poppins(
                                    color: R.appColors.textGreyColor,
                                    fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: "dont_have_an_account".L(),
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(SignUpPage.route);
                                      },
                                    text: "sign_up".L(),
                                    style: R.textStyles.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
