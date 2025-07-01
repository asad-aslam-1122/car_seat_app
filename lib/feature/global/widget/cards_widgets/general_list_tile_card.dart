import 'package:car_seat/feature/user/data/model/child_info_model.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../../user/presentation/provider/base_pages_section_provider.dart';

class GeneralLisTileCard extends StatefulWidget {
  final ListTileModel listTileModel;
  final int index;
  final Function onRemoveItemTab;
  final Function onEditItemTab;
  final bool? isVehicleModel;

  const GeneralLisTileCard(
      {super.key,
      required this.listTileModel,
      required this.index,
      this.isVehicleModel = false,
      required this.onEditItemTab,
      required this.onRemoveItemTab});

  @override
  State<GeneralLisTileCard> createState() => _GeneralLisTileCardState();
}

class _GeneralLisTileCardState extends State<GeneralLisTileCard>
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
        shadowColor: R.appColors.black.withOpacity(0.38),
        child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            subtitle: Text(
              (widget.isVehicleModel ?? false)
                  ? "${"license_plate".L()}: ${widget.listTileModel.subTitle}"
                  : "${int.parse(DateFormat("y").format(DateTime.now())) - int.parse(DateFormat("y").format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.listTileModel.subTitle))))} ${"years".L()}",
              style: R.textStyles.poppins(
                  fontWeight: FontWeight.w500,
                  color: R.appColors.darkTextGreyColor),
            ),
            title: Text(
              (widget.isVehicleModel ?? false)
                  ? "${widget.index + 1}: ${widget.listTileModel.title} ${widget.listTileModel.careModel} ${widget.listTileModel.carYear}"
                  : "${widget.index + 1}: ${widget.listTileModel.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles
                  .poppins(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            leading: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: widget.listTileModel.profileImg != null
                          ? FileImage(widget.listTileModel.profileImg!)
                          : AssetImage(R.appImages.carImg),
                      fit: BoxFit.cover)),
              height: 45,
              width: 45,
            )),
      ),
    );
  }
}
