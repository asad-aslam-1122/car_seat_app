// import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../resources/resources.dart';
//
// class PhoneNumberPicker extends StatefulWidget {
//   final ValueSetter<PhoneNumber>? phoneNumber;
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final String? phone;
//   final PhoneNumber? number;
//   final bool? isShowSuffix;
//   const PhoneNumberPicker(
//       {super.key,
//       this.phoneNumber,
//       this.phone,
//       required this.controller,
//       required this.focusNode,
//       this.isShowSuffix,
//       this.number});
//
//   @override
//   PhoneNumberPickerState createState() => PhoneNumberPickerState();
// }
//
// class PhoneNumberPickerState extends State<PhoneNumberPicker> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   String initialCountry = 'PK';
//   PhoneNumber number = PhoneNumber(isoCode: 'PK');
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//           brightness: context.read<BasePagesSectionProvider>().isDarkTheme
//               ? Brightness.dark
//               : Brightness.light),
//       child: InternationalPhoneNumberInput(
//         formatInput: true,
//         keyboardAction: TextInputAction.next,
//         keyboardType: TextInputType.number,
//         key: const Key('phone_number'),
//         textStyle:
//             R.textStyles.poppins(fontSize: 16.sp, color: R.appColors.black),
//         selectorTextStyle:
//             R.textStyles.poppins(fontSize: 16.sp, color: R.appColors.black),
//         searchBoxDecoration: R.decoration.inputDecorationWithHint(
//           hintText: "search_by_country_name_or_code",
//         ),
//         inputDecoration: R.decoration.inputDecorationWithLabel(
//           labelText: 'phone_number',
//           suffixIcon: (widget.isShowSuffix ?? false)
//               ? Image.asset(
//                   R.appImages.phoneIcon,
//                   scale: 4,
//                 )
//               : const SizedBox(),
//         ),
//         onInputChanged: (PhoneNumber pNumber) {
//           number = pNumber;
//           if (widget.phoneNumber != null) {
//             widget.phoneNumber!(number);
//           }
//         },
//         onInputValidated: (bool value) {},
//         textAlignVertical: TextAlignVertical.center,
//         selectorConfig: const SelectorConfig(
//             selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//             showFlags: false,
//             trailingSpace: false,
//             setSelectorButtonAsPrefixIcon: true),
//         ignoreBlank: false,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         initialValue: widget.number ?? number,
//         textFieldController: widget.controller,
//         focusNode: widget.focusNode,
//       ),
//     );
//   }
// }
