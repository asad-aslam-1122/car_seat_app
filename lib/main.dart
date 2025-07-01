import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_seat/feature/app/base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/battory_management_section/battery_management_base_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/biometric_setup_page/bio_metric_set_up_page.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/profile_pages/sub_pages/preferences/preferences_page.dart';
import 'package:car_seat/feature/user/presentation/pages/landing_pages/splash_page.dart';
import 'package:car_seat/feature/user/presentation/provider/onboard_provider.dart';
import 'package:car_seat/resources/resources.dart';
import 'package:car_seat/routes/app_routes.dart';
import 'package:car_seat/services/hive_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import 'feature/global/constant/enums.dart';
import 'feature/user/presentation/pages/base_pages/profile_pages/sub_pages/customize_theme/customize_theme_page.dart';
import 'feature/user/presentation/pages/base_pages/profile_pages/sub_pages/emergency_contacts/emergency_contact_base_page.dart';
import 'feature/user/presentation/pages/core_pages/no_internet_screen.dart';
import 'feature/user/presentation/provider/base_pages_section_provider.dart';
import 'feature/user/presentation/provider/password_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("themeBox");
  await Hive.openBox("themeModeBox");
  await Hive.openBox("showcase");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: R.appColors.transparent));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardProvider()),
    ChangeNotifierProvider(create: (context) => PasswordStateProvider()),
    ChangeNotifierProvider(create: (context) => BasePagesSectionProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        HiveDb.getTheme(context);
        await HiveDb.getShowCase();
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          closeShowcase()
              .then((value) => Get.to(() => const NoInternetScreen()));
        }
        break;
      default:
        break;
    }
  }

  Future<void> closeShowcase() async {
    BasePagesSectionProvider provider =
        Get.context!.read<BasePagesSectionProvider>();
    if (Get.currentRoute == BasePage.route) {
      if (provider.selectedBaseIndex == 0) {
        log("your current route is ${Get.currentRoute} started");
        ShowCaseWidget.of(provider.myContext!).dismiss();
        await HiveDb.setShowCase(false, ShowCasePages.home);
        log("your current route is ${Get.currentRoute} ended");
      } else if (provider.selectedBaseIndex == 1) {
        log("your current route is ${Get.currentRoute} started");
        ShowCaseWidget.of(provider.myContext!).dismiss();
        await HiveDb.setShowCase(false, ShowCasePages.alert);
        log("your current route is ${Get.currentRoute} ended");
      } else if (provider.selectedBaseIndex == 2) {
        log("your current route is ${Get.currentRoute} started");
        ShowCaseWidget.of(provider.myContext!).dismiss();
        await HiveDb.setShowCase(false, ShowCasePages.manage);
        log("your current route is ${Get.currentRoute} ended");
      } else if (provider.selectedBaseIndex == 3) {
        log("your current route is ${Get.currentRoute} started");
        ShowCaseWidget.of(provider.myContext!).dismiss();
        await HiveDb.setShowCase(false, ShowCasePages.profileSettings);
        log("your current route is ${Get.currentRoute} ended");
      } else if (provider.selectedBaseIndex == 4) {
        log("your current route is ${Get.currentRoute} started");
        ShowCaseWidget.of(provider.myContext!).dismiss();
        await HiveDb.setShowCase(false, ShowCasePages.sos);
        log("your current route is ${Get.currentRoute} ended");
      }
    } else if (Get.currentRoute == EmergencyContactBasePages.route) {
      log("your current route is ${Get.currentRoute} started");
      ShowCaseWidget.of(provider.myContext!).dismiss();
      await HiveDb.setShowCase(false, ShowCasePages.emergency);
      log("your current route is ${Get.currentRoute} ended");
    } else if (Get.currentRoute == BioMetricSetUpPage.route) {
      log("your current route is ${Get.currentRoute} started");
      ShowCaseWidget.of(provider.myContext!).dismiss();
      await HiveDb.setShowCase(false, ShowCasePages.biometric);
      log("your current route is ${Get.currentRoute} ended");
    } else if (Get.currentRoute == BatteryManagementBasePage.route) {
      log("your current route is ${Get.currentRoute} started");
      ShowCaseWidget.of(provider.myContext!).dismiss();
      await HiveDb.setShowCase(false, ShowCasePages.batteryManaging);
      log("your current route is ${Get.currentRoute} ended");
    } else if (Get.currentRoute == CustomizeThemePage.route) {
      log("your current route is ${Get.currentRoute} started");
      ShowCaseWidget.of(provider.myContext!).dismiss();
      await HiveDb.setShowCase(false, ShowCasePages.themeCustomization);
      log("your current route is ${Get.currentRoute} ended");
    } else if (Get.currentRoute == PreferencesPage.route) {
      log("your current route is ${Get.currentRoute} started");
      ShowCaseWidget.of(provider.myContext!).dismiss();
      await HiveDb.setShowCase(false, ShowCasePages.preferences);
      log("your current route is ${Get.currentRoute} ended");
    }
  }

  void startConnectionStream() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, themeProvider, child) {
        return Sizer(builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            getPages: AppRoutes.pages,
            theme: ThemeData(
                primaryColor: themeProvider.themeModel.themeColor,
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: themeProvider.themeModel.themeColor,
                  selectionColor: themeProvider.themeModel.themeColor,
                  selectionHandleColor: themeProvider.themeModel.themeColor,
                )),
            title: 'Car Seat Companion',
            fallbackLocale: const Locale('en', 'US'),
            supportedLocales: const [
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback:
                (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale!.languageCode &&
                    locale.countryCode == deviceLocale.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            initialRoute: SplashPage.route,
            debugShowCheckedModeBanner: false,
          );
        });
      },
    );
  }
}
