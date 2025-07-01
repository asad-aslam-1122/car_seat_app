import 'dart:async';
import 'dart:developer';

import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../../global/widget/custom_button.dart';
import '../../../../global/widget/safe_area_widget.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  NoInternetScreenState createState() => NoInternetScreenState();
}

class NoInternetScreenState extends State<NoInternetScreen> {
  bool isChecking = false;
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.wifi:
        {
          Navigator.pop(context);
        }
        break;
      case ConnectivityResult.mobile:
        {
          Navigator.pop(context);
        }
        break;
      case ConnectivityResult.none:
        break;
      default:
        break;
    }
    debugPrint(result.toString());
  }

  void startConnectionStream() {}

  Future<bool> checkBeforeGoingBack() async {
    List<ConnectivityResult> result;
    result = await _connectivity.checkConnectivity();
    if (result.first == ConnectivityResult.mobile ||
        result.first == ConnectivityResult.wifi) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //FeatureDiscovery.dismissAll(Get.context);
    return WillPopScope(
      onWillPop: checkBeforeGoingBack,
      child: SafeAreaWidget(
        child: Scaffold(
          backgroundColor: R.appColors.white,
          body: Container(
            height: 100.h,
            width: 100.w,
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(R.appImages.noInternetGif,
                            height: 45.h, width: 100.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * .05, vertical: 20),
                          width: Get.width,
                          child: Text(
                            "no_internet_connection".L(),
                            style: R.textStyles.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isChecking
                    ? SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          color: R.appColors.red,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomButton(
                          title: 'retry',
                          textSize: 15.sp,
                          onPressed: () {
                            initConnectivity();
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
