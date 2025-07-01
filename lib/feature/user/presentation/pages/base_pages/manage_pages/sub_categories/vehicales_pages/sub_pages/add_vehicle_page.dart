import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/child_info_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../../resources/app_validator.dart';
import '../../../../../../../../../resources/resources.dart';
import '../../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../../global/widget/custom_button.dart';
import '../../../../../../../../global/widget/drop_down_widget.dart';

class AddVehiclePage extends StatefulWidget {
  static String route = "/AddVehiclePage";
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String? selectedCarMake;
  String? selectedCarModel;
  String? selectedCarYear;

  List<String> carMakeList = ["Audi", "BMW", "Chery", "Datsun", "Ford", "GMC"];

  List<String> carModelList = [
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "A8",
  ];

  List<String> carYearList = [
    "2024",
    "2023",
    "2022",
    "2021",
  ];

  bool isEditAble = false;
  int index = 0;

  ListTileModel? vehicleModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEditAble = Get.arguments["isEditAble"];
    index = Get.arguments["index"];
    vehicleModel = Get.arguments["vehicleModel"];

    if (vehicleModel != null) {
      carYearValidate = true;
      carModelValidate = true;
      carMakeValidate = true;
      selectedCarMake = vehicleModel?.title;
      selectedCarModel = vehicleModel?.careModel;
      selectedCarYear = vehicleModel?.carYear;
      licensePlateTC.text = vehicleModel?.subTitle ?? "";
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController licensePlateTC = TextEditingController();
  FocusNode licensePlateFN = FocusNode();

  bool carMakeValidate = false;
  bool carYearValidate = false;
  bool carModelValidate = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    licensePlateFN.dispose();
    licensePlateTC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, addVehicleProvider, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: addVehicleProvider.themeModel.themeColor,
            appBar: AppBar(
              backgroundColor: addVehicleProvider.themeModel.themeColor,
              surfaceTintColor: addVehicleProvider.themeModel.themeColor,
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
                isEditAble ? "edit_vehicle".L() : "add_vehicle".L(),
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
                decoration: R.decoration
                    .topRadius(radius: 30, backgroundColor: R.appColors.white),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GlobalWidgets.labelText(text: "car_make"),
                      DropdownWidget(
                        hintText: "car_make",
                        list: carMakeList,
                        onChanged: (selectedValue) {
                          selectedCarMake = selectedValue!;
                          if (selectedValue != null) {
                            carMakeValidate = true;
                          }
                          setState(() {});
                        },
                        validator: AppValidator.validateDropdown,
                        selectedValue: selectedCarMake,
                      ),
                      GlobalWidgets.labelText(text: "car_model"),
                      DropdownWidget(
                        hintText: "car_model",
                        list: carModelList,
                        onChanged: (selectedValue) {
                          selectedCarModel = selectedValue!;
                          if (selectedValue != null) {
                            carModelValidate = true;
                          }
                          setState(() {});
                        },
                        validator: AppValidator.validateDropdown,
                        selectedValue: selectedCarModel,
                      ),
                      GlobalWidgets.labelText(text: "car_year"),
                      DropdownWidget(
                        hintText: "car_year",
                        list: carYearList,
                        onChanged: (selectedValue) {
                          setState(() {
                            selectedCarYear = selectedValue!;
                            if (selectedValue != null) {
                              carYearValidate = true;
                            }
                            setState(() {});
                          });
                        },
                        validator: AppValidator.validateDropdown,
                        selectedValue: selectedCarYear,
                      ),
                      GlobalWidgets.labelText(text: "license_plate"),
                      TextFormField(
                        controller: licensePlateTC,
                        focusNode: licensePlateFN,
                        canRequestFocus: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setState(() {});
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: R.textStyles.poppins(
                          fontSize: 16.sp,
                          color: R.appColors.black,
                        ),
                        decoration: R.decoration.inputDecorationWithLabel(
                          labelText: "license_plate",
                        ),
                        validator: AppValidator.validateLicense,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: R.appColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Opacity(
                opacity: (carYearValidate &&
                        carModelValidate &&
                        carMakeValidate &&
                        licensePlateTC.text.trim().isNotEmpty)
                    ? 1
                    : 0.5,
                child: CustomButton(
                    onPressed: (carYearValidate &&
                            carModelValidate &&
                            carMakeValidate &&
                            licensePlateTC.text.trim().isNotEmpty)
                        ? () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ListTileModel vehicleInfo = ListTileModel(
                                title: selectedCarMake.toString(),
                                subTitle: licensePlateTC.text,
                                careModel: selectedCarModel,
                                carYear: selectedCarYear,
                              );

                              if (isEditAble) {
                                addVehicleProvider.vehicleList[index] =
                                    vehicleInfo;
                                ZBotToast.showCustomToast(
                                    context,
                                    "vehicle_updated",
                                    "vehicle_has_been_updated_successfully");
                              } else {
                                addVehicleProvider.vehicleList.add(vehicleInfo);
                                ZBotToast.showCustomToast(
                                    context,
                                    "vehicle_added",
                                    "vehicle_has_been_added_successfully");
                              }

                              addVehicleProvider.update();
                              Get.back();
                            }
                          }
                        : () {},
                    title: isEditAble ? "update" : "add"),
              ),
            ),
          ),
        );
      },
    );
  }
}
