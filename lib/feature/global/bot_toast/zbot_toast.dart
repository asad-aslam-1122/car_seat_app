import 'package:bot_toast/bot_toast.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import 'my_loader.dart';

class ZBotToast {
  static Future loadingClose() async {
    BotToast.cleanAll();
    await Future.delayed(const Duration(milliseconds: 100));
  }

  static void showCustomToast(
      BuildContext context, String title, String subTitle) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: R.appColors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                color: Colors.black.withOpacity(0.28),
              )),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: R.appColors.white,
                        boxShadow: [
                          BoxShadow(
                              color: R.appColors.black.withOpacity(0.2),
                              spreadRadius: 8,
                              blurRadius: 30)
                        ]),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      leading: Image.asset(
                        R.appImages.checkIcon,
                        scale: 3,
                      ),
                      title: Text(
                        title.L(),
                        style: R.textStyles.poppins(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        subTitle.L(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: R.textStyles.poppins(
                          color: R.appColors.textGreyColor,
                        ),
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  static loadingShow() async {
    BotToast.showCustomLoading(
        toastBuilder: (func) {
          return MyLoader(
            color: R.appColors.red,
          );
        },
        allowClick: false,
        clickClose: false,
        backgroundColor: Colors.transparent);
    Future.delayed(const Duration(seconds: 60), () => loadingClose());
  }

  static showToastSuccess(
      {@required String? message, Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: Get.height * 0.02),
                decoration: BoxDecoration(
                    color: const Color(0xff85BB65),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            message!.L(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 3));
  }

  static showToastError({@required String? message, Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
                decoration: BoxDecoration(
                    color: const Color(0xFFE6532D),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Error",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            message!.L(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 2));
  }

  static showToastSomethingWentWrong({Duration? duration}) async {
    await loadingClose();

    BotToast.showCustomText(
        toastBuilder: (func) {
          return Column(
            children: <Widget>[
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFFE6532D),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.circle, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Error",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            "something_went_wrong".L(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          );
        },
        clickClose: true,
        crossPage: true,
        animationReverseDuration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
        duration: duration ?? const Duration(seconds: 5));
  }
}
