import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/res/res.dart';

import '../../../res/app_styles.dart';
import '../../../widgets/base_page.dart';
import '../../../widgets/base_text.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key, required this.stt}) : super(key: key);

  final int stt;

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        child: Column(
      children: [
        Container(
          height: Spacing.viewPadding.top,
          // color: AppColors.BLACK,
        ),
        Container(
          height: Spacing.viewPadding.top,
          color: AppColors.BLACK,
        ),
        Center(
          child: AppText(
            widget.stt.toString(),
            style: AppStyle.DEFAULT_18_BOLD,
          ),
        ),
        SizedBox(
          width: Spacing.width,
          height: 100.0,
          child: Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Container(
                width: Spacing.width,
                height: 50.sp,
                decoration: const BoxDecoration(color: AppColors.BLACK),
              )),
        )
      ],
    ));
  }
}
