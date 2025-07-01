import 'package:car_seat/feature/global/bot_toast/zbot_toast.dart';
import 'package:car_seat/feature/global/constant/enums.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/device_info_list_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../../resources/app_validator.dart';
import '../../../../../../../../../resources/resources.dart';
import '../../../../../../../../global/widget/custom_button.dart';
import '../../../../../../../../global/widget/drop_down_widget.dart';

class CompleteSetupDevice extends StatefulWidget {
  static String route = "/CompleteSetupDevice";
  const CompleteSetupDevice({super.key});

  @override
  State<CompleteSetupDevice> createState() => _CompleteSetupDeviceState();
}

class _CompleteSetupDeviceState extends State<CompleteSetupDevice> {
  FocusNode buildDeviceNameFN = FocusNode();
  FocusNode customDeviceNameFN = FocusNode();

  TextEditingController buildDeviceNameTC = TextEditingController();
  TextEditingController customDeviceNameTC = TextEditingController();

  List<String> vehicleList = [
    "Audi A4",
    "BMW i7",
    "Honda Civic",
  ];

  List<String> kidsList = [
    "John Doe",
    "Tom Leech",
    "David Jack",
    "Henna Smith",
    "Tim Cook",
    "Smith David",
  ];

  String? selectedChild;
  String? selectedVehicle;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    buildDeviceNameFN.dispose();
    customDeviceNameFN.dispose();
    buildDeviceNameTC.dispose();
    customDeviceNameTC.dispose();
  }

  DeviceInfoListModel? deviceModel;

  bool isEditAble = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    isEditAble = Get.arguments["isEditAble"];
    deviceModel = Get.arguments["deviceModel"];
    buildDeviceNameTC.text = deviceModel?.title ?? "CSC Hardware 1";
    customDeviceNameTC.text = deviceModel?.name ?? "";
    if (deviceModel != null) {
      childValidity = true;
      vehicleValidity = true;
      selectedChild = kidsList.firstWhereOrNull(
        (element) => element == deviceModel!.assignedChild,
      );
      selectedVehicle = vehicleList.firstWhereOrNull(
        (element) => element == deviceModel!.assignedVehicle,
      );
    }
    if (isEditAble && deviceModel != null) {
      index = Get.arguments["index"];
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  bool vehicleValidity = false;
  bool childValidity = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, deviceConnectionProvider, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: deviceConnectionProvider.themeModel.themeColor,
            appBar: AppBar(
              backgroundColor: deviceConnectionProvider.themeModel.themeColor,
              surfaceTintColor: deviceConnectionProvider.themeModel.themeColor,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: R.appColors.white,
                  )),
              title: Text(
                isEditAble ? "edit_device".L() : "complete_setup".L(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  decoration: R.decoration.topRadius(
                      radius: 30, backgroundColor: R.appColors.white),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "assign_child_and_vehicle".L(),
                          style: R.textStyles.poppins(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "assign_a_child_and_vehicle_to_link_with_your_device_for_real_time_monitoring"
                              .L(),
                          style: R.textStyles.poppins(
                              fontWeight: FontWeight.w500,
                              color: R.appColors.black.withOpacity(0.38)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GlobalWidgets.labelText(text: "assigned_device"),
                        TextFormField(
                          controller: buildDeviceNameTC,
                          focusNode: buildDeviceNameFN,
                          canRequestFocus: true,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: R.textStyles.poppins(
                              fontSize: 16.sp, color: R.appColors.black),
                          decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "csc_hardware_1",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                              text: TextSpan(
                                  style: R.textStyles.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                TextSpan(text: "name_your_device_".L()),
                                TextSpan(
                                  text: "_optional_".L(),
                                  style: R.textStyles.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: R.appColors.textGreyColor),
                                )
                              ])),
                        ),
                        TextFormField(
                          controller: customDeviceNameTC,
                          focusNode: customDeviceNameFN,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: R.textStyles.poppins(
                              fontSize: 16.sp, color: R.appColors.black),
                          decoration: R.decoration.inputDecorationWithLabel(
                            labelText: "name_your_device",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  GlobalWidgets.labelText(
                                      text: "assign_child_"),
                                  DropdownWidget(
                                    hintText: "select_kid",
                                    list: kidsList,
                                    onChanged: (val) {
                                      selectedChild = val!;
                                      if (val != null) {
                                        childValidity = true;
                                        setState(() {});
                                      }
                                    },
                                    validator: AppValidator.validateDropdown,
                                    selectedValue: selectedChild,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  GlobalWidgets.labelText(
                                      text: "assign_vehicle_"),
                                  DropdownWidget(
                                    hintText: "select_vehicle",
                                    list: vehicleList,
                                    onChanged: (val) {
                                      selectedVehicle = val!;
                                      if (val != null) {
                                        vehicleValidity = true;
                                        setState(() {});
                                      }
                                    },
                                    validator: AppValidator.validateDropdown,
                                    selectedValue: selectedVehicle,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            bottomNavigationBar: Container(
              color: R.appColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Opacity(
                opacity: (childValidity && vehicleValidity) ? 1 : 0.5,
                child: CustomButton(
                    onPressed: (childValidity && vehicleValidity)
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              DeviceInfoListModel deviceInfoListModel =
                                  DeviceInfoListModel(
                                      title: customDeviceNameTC.text.isEmpty
                                          ? buildDeviceNameTC.text
                                          : customDeviceNameTC.text,
                                      name: customDeviceNameTC.text,
                                      deviceStates: DeviceStates.connected,
                                      deviceBatteryStatus: 70,
                                      deviceImg: R.appImages.seatImg,
                                      assignedChild: selectedChild,
                                      assignedVehicle: selectedVehicle);
                              if (isEditAble) {
                                deviceConnectionProvider.devicesList[index] =
                                    deviceInfoListModel;
                                ZBotToast.showCustomToast(
                                    context,
                                    'device_updated',
                                    "device_has_been_updated_successfully");
                              } else {
                                deviceConnectionProvider.devicesList
                                    .add(deviceInfoListModel);
                                ZBotToast.showCustomToast(
                                    context,
                                    'device_added',
                                    "device_has_been_added_successfully");
                              }

                              deviceConnectionProvider.update();

                              Get.back();
                            }
                          }
                        : () {},
                    title: isEditAble ? "update" : "complete_setup"),
              ),
            ),
          ),
        );
      },
    );
  }
}
