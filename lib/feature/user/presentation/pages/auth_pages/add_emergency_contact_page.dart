import 'dart:io';

import 'package:car_seat/feature/app/base_page.dart';
import 'package:car_seat/feature/global/constant/constants.dart';
import 'package:car_seat/feature/global/widget/global_widgets/global_widgets.dart';
import 'package:car_seat/feature/global/widget/safe_area_widget.dart';
import 'package:car_seat/feature/user/data/model/contact_model.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/app_validator.dart';
import '../../../../../resources/resources.dart';
import '../../../../global/bot_toast/zbot_toast.dart';
import '../../../../global/widget/custom_button.dart';
import '../../../../global/widget/drop_down_widget.dart';
import '../../../../global/widget/image_picker/image_widget.dart';

class AddEmergencyContactPage extends StatefulWidget {
  static String route = "/AddEmergencyContactPage";
  const AddEmergencyContactPage({super.key});

  @override
  State<AddEmergencyContactPage> createState() =>
      _AddEmergencyContactPageState();
}

class _AddEmergencyContactPageState extends State<AddEmergencyContactPage> {
  File? profileImage;
  bool isValidate = false;
  final _formKey = GlobalKey<FormState>();

  bool isFromSignUp = false;
  bool isEditAble = false;
  String appBarTitle = "";
  int index = 0;

  TextEditingController nameTC = TextEditingController();
  TextEditingController phoneNumberTC = TextEditingController();

  FocusNode nameFN = FocusNode();
  FocusNode phoneNumberFN = FocusNode();
  // PhoneNumber number = PhoneNumber();
  List<String> relationsList = [
    "Father",
    "Mother",
    "Brother",
    "Sister",
    "Guardian"
  ];

  List<String> purityList = [
    "1st",
    "2nd",
    "3rd",
  ];

  String? selectedRelation;
  String? selectedPurity;

  ContactModel? contactModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    index = Get.arguments["index"];
    isEditAble = Get.arguments["isEditAble"];
    appBarTitle = Get.arguments["appBarTitle"];
    isFromSignUp = Get.arguments["isFromSignUp"];

    if (isEditAble) {
      contactModel = Get.arguments["contactModel"];
      selectedRelation = contactModel!.relation;
      selectedPurity = contactModel!.purity;
      profileImage = contactModel!.profileImage;
      nameTC.text = contactModel!.name;
      phoneNumberTC.text = contactModel!.mobileNumber;
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberTC.dispose();
    phoneNumberFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, emergencyContactProvider, child) {
        return SafeAreaWidget(
          child: Scaffold(
            backgroundColor: emergencyContactProvider.themeModel.themeColor,
            appBar: AppBar(
              backgroundColor: emergencyContactProvider.themeModel.themeColor,
              surfaceTintColor: emergencyContactProvider.themeModel.themeColor,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: R.appColors.white,
                    size: 25,
                  )),
              centerTitle: true,
              title: Text(
                appBarTitle.L(),
                textAlign: TextAlign.center,
                style: R.textStyles.poppins(
                    fontSize: 18.sp,
                    color: R.appColors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            body: Container(
              width: 100.w,
              height: 100.h,
              padding: const EdgeInsets.all(20),
              decoration: R.decoration
                  .topRadius(radius: 40, backgroundColor: R.appColors.white),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isEditAble && (profileImage != null)
                              ? Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(profileImage!),
                                          fit: BoxFit.cover)),
                                  height: 60,
                                  width: 60,
                                )
                              : ImageWidget(
                                  height: 60,
                                  width: 60,
                                  isShowCamera: false,
                                  isFile: true,
                                  uploadImage: (value) {
                                    if (value != null) {
                                      profileImage = value;
                                      isValidate = false;
                                      setState(() {});
                                    }
                                  }),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "profile_picture".L(),
                                style: R.textStyles.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "click_to_upload_an_image".L(),
                                style: R.textStyles
                                    .poppins(color: R.appColors.textGreyColor),
                              ),
                              if (!(profileImage != null ||
                                  isValidate == false))
                                Text(
                                  "please_upload_profile_image".L(),
                                  style: R.textStyles.poppins(
                                      fontSize: 14.sp, color: R.appColors.red),
                                ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GlobalWidgets.labelText(text: "name"),
                      TextFormField(
                        controller: nameTC,
                        focusNode: nameFN,
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        canRequestFocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: R.textStyles
                            .poppins(fontSize: 16.sp, color: R.appColors.black),
                        decoration: R.decoration.inputDecorationWithLabel(
                          labelText: "name",
                        ),
                        validator: AppValidator.validateFullName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GlobalWidgets.labelText(text: "phone_number_"),
                      // PhoneNumberPicker(
                      //   controller: phoneNumberTC,
                      //   focusNode: phoneNumberFN,
                      //   phoneNumber: (pNumber) {
                      //     number = pNumber;
                      //   },
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                GlobalWidgets.labelText(text: "relation_"),
                                DropdownWidget(
                                  hintText: "select_relation",
                                  list: relationsList,
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      selectedRelation = selectedValue!;
                                    });
                                  },
                                  validator: AppValidator.validateDropdown,
                                  selectedValue: selectedRelation,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                GlobalWidgets.labelText(text: "priority_"),
                                DropdownWidget(
                                  hintText: "select_purity",
                                  list: purityList,
                                  onChanged: (selectedValue) {
                                    setState(() {
                                      selectedPurity = selectedValue!;
                                    });
                                  },
                                  validator: AppValidator.validateDropdown,
                                  selectedValue: selectedPurity,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: R.appColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        profileImage != null) {
                      ContactModel contactModel = ContactModel(
                          profileImage: profileImage!,
                          name: nameTC.text,
                          mobileNumber: phoneNumberTC.text,
                          relation: selectedRelation!,
                          purity: selectedPurity!);

                      if (isFromSignUp) {
                        ZBotToast.showCustomToast(
                            context,
                            'emergency_contact_added',
                            "contact_has_been_added_successfully");
                        emergencyContactProvider.selectedBaseIndex = 0;
                        emergencyContactProvider.currentPage =
                            Constants.pagesList[0];
                        emergencyContactProvider.update();
                        Get.offAllNamed(BasePage.route);
                      } else if (isEditAble) {
                        emergencyContactProvider.emergencyContactList[index] =
                            contactModel;
                        emergencyContactProvider.update();

                        ZBotToast.showCustomToast(context, 'contact_updated',
                            "contact_has_been_updated_successfully");

                        Get.back();
                      } else {
                        emergencyContactProvider.emergencyContactList
                            .add(contactModel);
                        emergencyContactProvider.update();
                        ZBotToast.showCustomToast(
                            context,
                            'emergency_contact_added',
                            "contact_has_been_added_successfully");

                        Get.back();
                      }
                    } else {
                      setState(() {
                        isValidate = true;
                      });
                    }
                  },
                  title: isEditAble ? "update" : "add"),
            ),
          ),
        );
      },
    );
  }
}
