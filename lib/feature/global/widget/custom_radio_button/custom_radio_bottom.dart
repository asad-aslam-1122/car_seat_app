import 'package:car_seat/feature/user/presentation/provider/base_pages_section_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../resources/resources.dart';

class CustomRadioBottom extends StatefulWidget {
  final dynamic radioBtnId;
  final dynamic radioGroupId;
  final VoidCallback onTab;
  const CustomRadioBottom(
      {super.key,
      required this.radioBtnId,
      required this.radioGroupId,
      required this.onTab});

  @override
  State<CustomRadioBottom> createState() => _CustomRadioBottomState();
}

class _CustomRadioBottomState extends State<CustomRadioBottom> {
  @override
  Widget build(BuildContext context) {
    BasePagesSectionProvider basePagesSectionProvider =
        context.read<BasePagesSectionProvider>();
    return GestureDetector(
      onTap: widget.onTab,
      child: Container(
          decoration: R.decoration
              .circleShapeWithBorder(borderColor: R.appColors.iconsGreyColor),
          child: Container(
            height: 15,
            width: 15,
            margin: const EdgeInsets.all(1.5),
            decoration: R.decoration.circleShapeWithShadow(
                backgroundColor: widget.radioGroupId == widget.radioBtnId
                    ? basePagesSectionProvider.themeModel.themeColor
                    : R.appColors.transparent,
                shadowColor: R.appColors.transparent),
          )),
    );
  }
}
