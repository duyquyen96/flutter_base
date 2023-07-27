import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sprint/res/colors.dart';
import '../../common/utils/spacing.dart';
import '../../res/app_styles.dart';
import 'base_text.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final bool backShow, shadowShow;
  final Widget? rightWidget;

  const BaseHeader({
    super.key,
    required this.title,
    this.backShow = true,
    this.shadowShow = true,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Spacing.viewPadding.top,
      ),
      height: Spacing.realHeaderHeight,
      decoration: BoxDecoration(
          color: AppColors.WHITE,
          boxShadow: !shadowShow ? null : [AppStyle.shadow10]),
      child: Row(children: [
        Stack(children: [
          if (rightWidget != null)
            Opacity(
              opacity: 0,
              child: IgnorePointer(child: rightWidget!),
            ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: backShow ? () => Get.back() : null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.paddingHorizontal,
              ),
              child: SizedBox(
                width: 20.sp,
                height: Spacing.headerHeight,
                child: backShow
                    ? SvgPicture.asset(
                        'assets/icons/back.svg',
                        width: 20.sp,
                        height: 20.sp,
                        fit: BoxFit.contain,
                      )
                    : null,
              ),
            ),
          ),
        ]),
        Expanded(
            child: AppText(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyle.DEFAULT_16.copyWith(fontWeight: FontWeight.w400),
        )),
        Stack(alignment: Alignment.centerRight, children: [
          SizedBox(
            width: Spacing.paddingHorizontal * 2 + 20.sp,
            height: Spacing.headerHeight,
          ),
          if (rightWidget != null) rightWidget!
        ])
      ]),
    );
  }
}
