import 'package:car_seat/feature/user/data/model/contact_model.dart';
// import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../user/presentation/provider/base_pages_section_provider.dart';

class ContactCard extends StatefulWidget {
  final ContactModel contactModel;
  final int index;
  final Function onRemoveItemTab;
  final Function onEditItemTab;
  final bool? showPhoneIcon;
  final bool? canEdit;
  final bool? showPurity;

  const ContactCard(
      {super.key,
      required this.contactModel,
      required this.index,
      this.showPhoneIcon = false,
      this.canEdit = true,
      this.showPurity = true,
      required this.onEditItemTab,
      required this.onRemoveItemTab});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard>
    with TickerProviderStateMixin {
  late SlidableController controller;

  @override
  void initState() {
    controller = SlidableController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BasePagesSectionProvider basePagesSectionProvider =
        Get.context!.read<BasePagesSectionProvider>();

    return Slidable(
      controller: controller,
      enabled: (widget.canEdit ?? true),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () {
              controller.close();
              widget.onEditItemTab();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(
                R.appImages.editIcon,
                color: basePagesSectionProvider.themeModel.themeColor,
                height: 25,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.close();
              widget.onRemoveItemTab();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: Image.asset(
                R.appImages.deleteIcon,
                color: R.appColors.red,
                height: 25,
              ),
            ),
          )
        ],
      ),
      child: Card(
        color: R.appColors.white,
        elevation: 8,
        margin: EdgeInsets.zero,
        shadowColor: R.appColors.black.withOpacity(0.38),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: widget.contactModel.profileImage == null
                            ? AssetImage(R.appImages.profileIcon)
                            : FileImage(widget.contactModel.profileImage!),
                        fit: BoxFit.cover)),
                height: 45,
                width: 45,
              ),
              if ((widget.showPurity ?? true))
                Positioned(
                  top: -2,
                  left: -2,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: R.appColors.white,
                        border: Border.all(
                            color: basePagesSectionProvider
                                .themeModel.themeColor)),
                    child: Center(
                      child: Text(
                        widget.contactModel.purity,
                        style: R.textStyles
                            .poppins(fontSize: 6, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          subtitle: (widget.canEdit ?? true)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contactModel.relation,
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w500,
                          color: R.appColors.black.withOpacity(0.38)),
                    ),
                    Text(
                      widget.contactModel.mobileNumber,
                      style: R.textStyles.poppins(
                          fontWeight: FontWeight.w500,
                          color: R.appColors.black.withOpacity(0.38)),
                    ),
                  ],
                )
              : null,
          title: Text(
            (widget.canEdit ?? true)
                ? "${widget.index + 1}: ${widget.contactModel.name}"
                : widget.contactModel.name,
            style: R.textStyles
                .poppins(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),

          // subtitle: widget.contactModel.relation == "" &&
          //         widget.contactModel.mobileNumber == ""
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             widget.contactModel.relation,
          //             style: R.textStyles.poppins(
          //                 fontWeight: FontWeight.w500,
          //                 color: R.appColors.black.withOpacity(0.38)),
          //           ),
          //           Text(
          //             widget.contactModel.mobileNumber,
          //             style: R.textStyles.poppins(
          //                 fontWeight: FontWeight.w500,
          //                 color: R.appColors.black.withOpacity(0.38)),
          //           ),
          //         ],
          //       )
          //     : null,
          trailing: (widget.showPhoneIcon ?? false)
              ? IconButton(
                  onPressed: () async {
                    // await DirectCallPlus.makeCall((widget.canEdit ?? true)
                    //     ? widget.contactModel.mobileNumber
                    //     : widget.contactModel.name);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(R.appColors.red),
                      shape: const WidgetStatePropertyAll(CircleBorder())),
                  icon: Icon(
                    Icons.phone,
                    color: R.appColors.white,
                  ))
              : null,
        ),
      ),
    );
  }
}
