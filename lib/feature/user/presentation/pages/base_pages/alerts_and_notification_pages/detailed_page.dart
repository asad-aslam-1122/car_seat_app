import 'dart:async';

import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../global/constant/constants.dart';

class AlertDetailedPage extends StatefulWidget {
  static String route = "/AlertDetailedPage";
  const AlertDetailedPage({super.key});

  @override
  State<AlertDetailedPage> createState() => _AlertDetailedPageState();
}

class _AlertDetailedPageState extends State<AlertDetailedPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final marker = <Marker>{};
  late final CameraPosition cameraPosition;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        index = Get.arguments["indexValue"];
        cameraPosition = CameraPosition(
          target: Constants.currentLatLng,
          zoom: 14,
        );

        marker.add(Marker(
            markerId: const MarkerId('currentLocation'),
            position: Constants.currentLatLng));
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
        builder: (context, themeColorProvider, child) {
      return SafeAreaWidget(
        child: Scaffold(
          backgroundColor: themeColorProvider.themeModel.themeColor,
          appBar: AppBar(
            backgroundColor: themeColorProvider.themeModel.themeColor,
            surfaceTintColor: themeColorProvider.themeModel.themeColor,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: R.appColors.white,
                )),
            centerTitle: true,
            title: Text(
              "alert".L(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      index == 1
                          ? "Temperature Change"
                          : index == 2
                              ? "Child Inactivity"
                              : "Pressure Detection",
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w600, fontSize: 18.sp),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "alert_".L(),
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                  Text(
                    index == 1
                        ? "A significant temperature change has been detected in your vehicle, which could endanger your child's well-being. Extreme temperatures can lead to discomfort or even heat-related illnesses if not addressed promptly. This alert is crucial for ensuring that your child, John Doe , remains safe and comfortable. Please take immediate action to check the temperature inside the vehicle and ensure your child is secure."
                        : index == 2
                            ? "Your child, John Doe, has been inactive in the vehicle for an extended period, triggering this alert. This situation raises concerns for their safety and well-being, as prolonged inactivity could indicate a serious issue. It is vital that you check on John Doe immediately to ensure they are safe, secure, and comfortable in their seat. Please take swift action to assess their condition and respond accordingly."
                            : "A pressure irregularity has been detected in your vehicle, which poses a potential risk to the safety of your child. It is essential to take immediate action to verify the pressure status within the vehicle. This alert indicates that the pressure may have dropped below safe levels, which could affect the child’s security and comfort. Please check your child’s condition and the vehicle's pressure settings to ensure everything is functioning properly.",
                    style: R.textStyles.poppins(
                        fontWeight: FontWeight.w400,
                        color: R.appColors.black.withOpacity(0.38)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "child_information_".L(),
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          style: R.textStyles.poppins(
                              color: R.appColors.black,
                              fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(text: "name".L()),
                        const TextSpan(text: "\t"),
                        TextSpan(
                          text: "John Doe",
                          style: R.textStyles.poppins(
                              color: R.appColors.black.withOpacity(0.38),
                              fontWeight: FontWeight.w500),
                        ),
                      ])),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "vehicle_information_".L(),
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          style: R.textStyles.poppins(
                              color: R.appColors.black,
                              fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(text: "make_model_".L()),
                        const TextSpan(text: "\t"),
                        TextSpan(
                          text: "Audi 22",
                          style: R.textStyles.poppins(
                              color: R.appColors.black.withOpacity(0.38),
                              fontWeight: FontWeight.w500),
                        ),
                      ])),
                  const SizedBox(
                    height: 2,
                  ),
                  RichText(
                      text: TextSpan(
                          style: R.textStyles.poppins(
                              color: R.appColors.black,
                              fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(text: "license_plate_".L()),
                        const TextSpan(text: "\t"),
                        TextSpan(
                          text: "A8049CS",
                          style: R.textStyles.poppins(
                              color: R.appColors.black.withOpacity(0.38),
                              fontWeight: FontWeight.w500),
                        ),
                      ])),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "current_location_".L(),
                    style: R.textStyles
                        .poppins(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                  InkWell(
                    onTap: () async {
                      List<AvailableMap> availableMaps =
                          await MapLauncher.installedMaps;
                      await availableMaps.first.showMarker(
                        coords: Coords(Constants.currentLatLng.latitude,
                            Constants.currentLatLng.longitude),
                        title: Constants.currentLocation,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        Constants.currentLocation,
                        style: R.textStyles.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: R.appColors.blueColor,
                            textDecoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  googleMapBox(themeColorProvider),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget alertNotifications() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {},
            title: Row(
              children: [
                if (index == 0)
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: R.appColors.greenColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  index == 1
                      ? "Temporature Alert"
                      : index == 2
                          ? "InActivity Alert"
                          : "Pressure Alert",
                  style: R.textStyles.poppins(
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                    color: R.appColors.black,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              index == 1
                  ? "A temperature alert is shared with your secondary emergency contacts. Click to view the amber alert."
                  : index == 2
                      ? "An inactivity alert call is triggered to 911 for safety of your child."
                      : "A pressure alert is shared with your secondary emergency contacts. Click to view the amber alert",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                fontSize: 12.sp,
                color: R.appColors.black.withOpacity(0.38),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: R.appColors.lightGreyColor,
              child: Image.asset(
                index == 1
                    ? R.appImages.temporatureIcon
                    : index == 2
                        ? R.appImages.inActivityIcon
                        : R.appImages.pressureIcon,
                scale: 4,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    index == 0 ? "now".L() : "2 mins ago",
                    style: R.textStyles.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: R.appColors.textGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0, // Remove default vertical spacing
          thickness: 1, // Set thickness as per design
          color: R.appColors.black.withOpacity(0.1),
        );
      },
    );
  }

  Widget simpleNotifications() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: index == 0
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: R.appColors.lightGreyColor,
                )
              : null,
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {},
            title: Row(
              children: [
                if (index == 0)
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: R.appColors.greenColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Pressure Alert",
                  style: R.textStyles.poppins(
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14.sp,
                    color: R.appColors.black,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "A pressure alert is shared with your secondary emergency contacts. Click to view the amber alert",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                fontSize: 12.sp,
                color: R.appColors.black.withOpacity(0.38),
              ),
            ),
            leading: CircleAvatar(
              backgroundColor: R.appColors.lightGreyColor,
              child: Image.asset(
                R.appImages.pressureIcon,
                scale: 4,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    index == 0 ? "now".L() : "2 mins ago",
                    style: R.textStyles.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: R.appColors.textGreyColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0, // Remove default vertical spacing
          thickness: 1, // Set thickness as per design
          color: R.appColors.black.withOpacity(0.1),
        );
      },
    );
  }

  Widget googleMapBox(BasePagesSectionProvider themeColorProvider) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          height: 22.h,
          width: 90.w,
          child: Card(
            shadowColor: R.appColors.iconsGreyColor.withOpacity(0.38),
            elevation: 8,
            color: R.appColors.white,
            child: GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition: cameraPosition,
              markers: marker.toSet(),
              style: themeColorProvider.isDarkTheme
                  ? Constants.mapStyleDark
                  : Constants.mapStyleLight,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ),
      ),
    );
  }
}
