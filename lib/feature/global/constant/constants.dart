import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import '../../../resources/resources.dart';
import '../../user/data/model/bottom_navigation_model.dart';
import '../../user/data/model/contact_model.dart';
import '../../user/data/model/theme_model.dart';
import '../../user/data/model/title_subtitle_model.dart';
import '../../user/presentation/pages/base_pages/alerts_and_notification_pages/alert_notification_base_page.dart';
import '../../user/presentation/pages/base_pages/home_pages/home_base_pages.dart';
import '../../user/presentation/pages/base_pages/manage_pages/manage_base_page.dart';
import '../../user/presentation/pages/base_pages/profile_pages/profile_base_page.dart';
import '../../user/presentation/pages/base_pages/sos_pages/sos_dashboard_base_pages.dart';

class Constants {
  static final themeBox = Hive.box("themeBox");
  static const themeKey = "themeKey";
  static final themeModeBox = Hive.box("themeModeBox");
  static const themeModeKey = "themeModeKey";
  static String googleMapAPIKey = "AIzaSyB3-PXBvW4UuH10ZRBY7kd20EFcxDZksQU";
  static bool isShowCaseHome = true;
  static bool isShowCaseAlert = true;
  static bool isShowCaseSOS = true;
  static bool isShowCaseManage = true;
  static bool isShowCaseProfile = true;
  static bool isShowCaseEmergency = true;
  static bool isShowCaseBiometric = true;
  static bool isShowCaseBattery = true;
  static bool isShowCaseTheme = true;
  static bool isShowCasePreferences = true;

  static ContactModel dummyContactModel = ContactModel(
      name: "William James",
      mobileNumber: "3333333333333333",
      relation: "Brother",
      purity: "1st");

  static List<BottomNavigationModel> bottomIconsList = [
    BottomNavigationModel(title: "home", iconImg: R.appImages.homeIcon),
    BottomNavigationModel(title: "alert", iconImg: R.appImages.alertIcon),
    BottomNavigationModel(title: "manage", iconImg: R.appImages.manageIcon),
    BottomNavigationModel(
        title: "profile", iconImg: R.appImages.profileBottomIcon),
  ];

  static List<ThemeModel> themeModelList = [
    ThemeModel(
      themeColor: R.appColors.defaultPrimaryColor,
      themeTitle: "default",
      id: "0",
    ),
    ThemeModel(
      themeColor: R.appColors.primaryPurpleColor,
      themeTitle: "purple",
      id: "1",
    ),
    ThemeModel(
      themeColor: R.appColors.primaryGreenColor,
      themeTitle: "green",
      id: "2",
    ),
    ThemeModel(
      themeColor: R.appColors.primaryYellowColor,
      themeTitle: "yellow",
      id: "3",
    ),
    ThemeModel(
      themeColor: R.appColors.primaryPinkColor,
      themeTitle: "pink",
      id: "4",
    ),
  ];
  static List<TitleSubtitleModel> themeModesList = [
    TitleSubtitleModel(
      title: "light",
      subTitle: R.appImages.lightTheme,
    ),
    TitleSubtitleModel(
      title: "dark",
      subTitle: R.appImages.darkTheme,
    ),
    TitleSubtitleModel(
      title: "system",
      subTitle: R.appImages.systemTheme,
    ),
  ];
  static List<Widget> pagesList = [
    const HomeBasePages(),
    const AlertNotificationBasePage(),
    const ManageBasePages(),
    const ProfileBasePage(),
    const SosDashboardBasePage(),
  ];

  //Google Map Constants
  static LatLng currentLatLng = const LatLng(31.465562, 74.291168);
  static String currentLocation =
      "Block F Phase 1 Johar Town, Lahore, Punjab 54600, Pakistan";
  static String mapStyleDark = """[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]""";
  static String mapStyleLight = """[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]""";
}
