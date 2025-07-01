import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/utilities/will_pop_widget.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../user/presentation/provider/base_pages_section_provider.dart';

class BasePage extends StatefulWidget {
  static String route = "/BasePage";

  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final provider = context.read<BasePagesSectionProvider>();
        provider.currentPage = Constants.pagesList[0];
        provider.selectedBaseIndex = 0;
        provider.update();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, basePageSectionProvider, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: PopScopeWidget.onPopInvokedWithResult,
          child: SafeAreaWidget(
            child: Scaffold(
              backgroundColor: R.appColors.white,
              body: Column(children: [
                Expanded(child: basePageSectionProvider.currentPage),
                Container(
                  decoration: BoxDecoration(
                      color: R.appColors.white,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 10,
                            color: R.appColors.black.withOpacity(.1))
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                basePageSectionProvider.currentPage =
                                    Constants.pagesList[index];
                                basePageSectionProvider.selectedBaseIndex =
                                    index;
                                basePageSectionProvider.update();
                              },
                              child: Container(
                                color: R.appColors.white,
                                width: 18.w,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 2 ? 20 : 0,
                                      right: index == 1 ? 25 : 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        Constants
                                            .bottomIconsList[index].iconImg,
                                        height: 25,
                                        width: 25,
                                        color: basePageSectionProvider
                                                    .currentPage ==
                                                Constants.pagesList[index]
                                            ? basePageSectionProvider
                                                .themeModel.themeColor
                                            : R.appColors.iconsGreyColor,
                                        fit: BoxFit.fill,
                                      ),
                                      Text(
                                        Constants.bottomIconsList[index].title
                                            .L(),
                                        overflow: TextOverflow.ellipsis,
                                        style: R.textStyles.poppins(
                                            fontSize: 10,
                                            dontGiveTextHeight: true,
                                            color: basePageSectionProvider
                                                        .currentPage ==
                                                    Constants.pagesList[index]
                                                ? basePageSectionProvider
                                                    .themeModel.themeColor
                                                : R.appColors.iconsGreyColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ]),
              floatingActionButton: GestureDetector(
                onTap: () {
                  basePageSectionProvider.currentPage = Constants.pagesList[4];
                  basePageSectionProvider.selectedBaseIndex = 4;
                  basePageSectionProvider.update();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    R.appImages.sosIcon,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          ),
        );
      },
    );
  }
}
