import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sprint/res/app_styles.dart';
import 'package:sprint/res/colors.dart';
import 'package:sprint/widgets/base_text.dart';
import 'package:sprint/widgets/base_buttons.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    this.title,
    required this.content,
    this.leftTitle,
    this.rightTitle,
    this.leftPress,
    this.rightPress,
    this.showLeftButton = true,
    this.contentWidget,
  });

  final String? title;
  final String content;

  final String? rightTitle, leftTitle;
  final void Function()? leftPress;
  final void Function()? rightPress;
  final bool showLeftButton;
  final Widget? contentWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        decoration: BoxDecoration(
            color: AppColors.WHITE, borderRadius: BorderRadius.circular(20.sp)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.sp, bottom: 6.sp),
              child: AppText(
                title ?? 'Thông báo'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.DEFAULT_16
                    .copyWith(fontWeight: FontWeight.w600, height: 1.3),
              ),
            ),
            if (contentWidget != null)
              contentWidget!
            else
              AppText(
                content,
                textAlign: TextAlign.center,
                style:
                    AppStyle.DEFAULT_16.copyWith(fontWeight: FontWeight.w300),
              ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.sp, top: 16.sp),
              child: BaseCButtons(
                  leftTitle: leftTitle,
                  rightTitle: rightTitle,
                  showLeftButton: showLeftButton,
                  leftPress: leftPress ??
                      () {
                        Get.back();
                      },
                  rightPress: rightPress ??
                      () {
                        Get.back();
                      }),
            )
          ],
        ),
      )),
    );
  }
}
