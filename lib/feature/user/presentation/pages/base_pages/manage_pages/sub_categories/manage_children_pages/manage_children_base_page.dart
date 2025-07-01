import 'package:car_seat/feature/global/widget/cards_widgets/general_list_tile_card.dart';
import 'package:car_seat/feature/user/presentation/pages/base_pages/manage_pages/sub_categories/manage_children_pages/sub_pages/add_child_page.dart';
import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:car_seat/resources/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../resources/resources.dart';
import '../../../../../../../global/bot_toast/zbot_toast.dart';
import '../../../../../../../global/widget/global_widgets/global_widgets.dart';
import '../../../../../../data/model/child_info_model.dart';
import '../../../../core_pages/empty_case_page.dart';

class ManageChildrenBasePage extends StatefulWidget {
  const ManageChildrenBasePage({
    super.key,
  });

  @override
  State<ManageChildrenBasePage> createState() => _ManageChildrenBasePageState();
}

class _ManageChildrenBasePageState extends State<ManageChildrenBasePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BasePagesSectionProvider>(
      builder: (context, manageChildrenListProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "manage_children".L(),
              style: R.textStyles
                  .poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              "manage_all_your_children_easily".L(),
              style: R.textStyles.poppins(
                  color: R.appColors.textGreyColor,
                  fontWeight: FontWeight.w500),
            ),
            manageChildrenListProvider.childrenList.isEmpty
                ? EmptyCasePage(
                    title: "no_child_found".L(),
                    subTitle: "add_a_child_for_real_time_monitoring".L(),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemBuilder: (context, index) {
                        ListTileModel childModel =
                            manageChildrenListProvider.childrenList[index];
                        return GeneralLisTileCard(
                          listTileModel: childModel,
                          index: index,
                          onEditItemTab: () {
                            Get.toNamed(AddChildPage.route, arguments: {
                              "isEditAble": true,
                              "index": index,
                              "childModel": childModel
                            });
                          },
                          onRemoveItemTab: () {
                            GlobalWidgets.titleWithBtnBottomSheet(
                              onRightBtnPressed: () {
                                manageChildrenListProvider.childrenList
                                    .removeAt(index);
                                manageChildrenListProvider.update();

                                ZBotToast.showCustomToast(
                                    context,
                                    "child_removed",
                                    "child_has_been_removed_successfully");

                                Get.back();
                              },
                              title:
                                  "are_you_sure_you_want_to_remove_this_child_",
                            );
                          },
                        );
                      },
                      itemCount: manageChildrenListProvider.childrenList.length,
                    ),
                  )
          ],
        );
      },
    );
  }
}
