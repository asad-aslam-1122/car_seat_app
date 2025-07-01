import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/pages/landing_pages/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../resources/resources.dart';

class SplashPage extends StatefulWidget {
  static String route = "/SplashPage";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double topPosition = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), _startAnimation).then(
      (value) {
        Future.delayed(
          const Duration(milliseconds: 1600),
          () {
            Get.offAllNamed(OnboardPage.route);
          },
        );
      },
    );
  }

  void _startAnimation() {
    setState(() {
      topPosition = 450;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        backgroundColor: R.appColors.white,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOutQuad,
              top: 0,
              bottom: topPosition,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  R.appImages.cscLogo,
                  scale: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
