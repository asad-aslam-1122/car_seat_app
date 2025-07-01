import 'package:car_seat/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class EmptyCasePage extends StatelessWidget {
  String title, subTitle;
  double? titleSize;

  EmptyCasePage(
      {super.key, required this.title, required this.subTitle, this.titleSize});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: R.textStyles.poppins(
                  fontWeight: FontWeight.w600, fontSize: titleSize ?? 18.sp),
            ),
            Text(
              subTitle,
              style: R.textStyles.poppins(color: R.appColors.textGreyColor),
            )
          ],
        ),
      ),
    );
  }
}
