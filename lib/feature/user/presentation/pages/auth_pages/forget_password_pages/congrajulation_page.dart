import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/auth_pages/login_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../global/widget/custom_button.dart';

class CongrajulationPage extends StatefulWidget {
  static String route = "/CongrajulationPage";

  const CongrajulationPage({super.key});

  @override
  State<CongrajulationPage> createState() => _CongrajulationPageState();
}

class _CongrajulationPageState extends State<CongrajulationPage> {
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
                    height: 50.h,
                    decoration: R.decoration.bottomRadius(
                      backgroundColor: themeColor.themeModel.themeColor,
                      radius: 40,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              "congratulations".L(),
                              textAlign: TextAlign.center,
                              style: R.textStyles.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "you_ve_successfully_changed_your_password".L(),
                              textAlign: TextAlign.center,
                              style: R.textStyles.poppins(
                                color: R.appColors.black.withOpacity(0.38),
                                fontSize: 14.sp,
                              ),
                            ),
                            const SizedBox(height: 35),
                            CustomButton(
                              width: 100.w,
                              onPressed: () {
                                Get.offAllNamed(LoginPage.route);
                              },
                              title: "login",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
